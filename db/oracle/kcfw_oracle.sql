

/* Drop sys Indexes */

DROP INDEX sys_area_parent_id;
DROP INDEX sys_area_parent_ids;
DROP INDEX sys_area_del_flag;
DROP INDEX sys_dict_value;
DROP INDEX sys_dict_label;
DROP INDEX sys_dict_del_flag;
DROP INDEX sys_log_create_by;
DROP INDEX sys_log_request_uri;
DROP INDEX sys_log_type;
DROP INDEX sys_log_create_date;
DROP INDEX sys_mdict_parent_id;
DROP INDEX sys_mdict_parent_ids;
DROP INDEX sys_mdict_del_flag;
DROP INDEX sys_menu_parent_id;
DROP INDEX sys_menu_parent_ids;
DROP INDEX sys_menu_del_flag;
DROP INDEX sys_office_parent_id;
DROP INDEX sys_office_parent_ids;
DROP INDEX sys_office_del_flag;
DROP INDEX sys_office_type;
DROP INDEX sys_role_del_flag;
DROP INDEX sys_role_enname;
DROP INDEX sys_user_office_id;
DROP INDEX sys_user_login_name;
DROP INDEX sys_user_company_id;
DROP INDEX sys_user_update_date;
DROP INDEX sys_user_del_flag;

/* Drop test Indexes */

DROP INDEX test_data_del_flag 
DROP INDEX test_data_child_del_flag 
DROP INDEX test_data_main_del_flag
DROP INDEX test_tree_del_flag 
DROP INDEX test_data_parent_id 
DROP INDEX test_data_parent_ids 


/* Create cms Indexes */

DROP INDEX cms_article_DROP_by 
DROP INDEX cms_article_title 
DROP INDEX cms_article_keywords
DROP INDEX cms_article_del_flag 
DROP INDEX cms_article_weight 
DROP INDEX cms_article_update_date 
DROP INDEX cms_article_category_id
DROP INDEX cms_category_parent_id 
DROP INDEX cms_category_parent_ids 
DROP INDEX cms_category_module 
DROP INDEX cms_category_name 
DROP INDEX cms_category_sort 
DROP INDEX cms_category_del_flag
DROP INDEX cms_category_office_id 
DROP INDEX cms_category_site_id 
DROP INDEX cms_comment_category_id 
DROP INDEX cms_comment_content_id 
DROP INDEX cms_comment_status 
DROP INDEX cms_guestbook_del_flag
DROP INDEX cms_link_category_id 
DROP INDEX cms_link_title 
DROP INDEX cms_link_del_flag
DROP INDEX cms_link_weight 
DROP INDEX cms_link_DROP_by 
DROP INDEX cms_link_update_date 
DROP INDEX cms_site_del_flag 



/* Drop sys Tables */

DROP TABLE sys_user_role CASCADE CONSTRAINTS;
DROP TABLE sys_user CASCADE CONSTRAINTS;
DROP TABLE sys_role_office CASCADE CONSTRAINTS;
DROP TABLE sys_office CASCADE CONSTRAINTS;
DROP TABLE sys_area CASCADE CONSTRAINTS;
DROP TABLE sys_dict CASCADE CONSTRAINTS;
DROP TABLE sys_log CASCADE CONSTRAINTS;
DROP TABLE sys_mdict CASCADE CONSTRAINTS;
DROP TABLE sys_role_menu CASCADE CONSTRAINTS;
DROP TABLE sys_menu CASCADE CONSTRAINTS;
DROP TABLE sys_role CASCADE CONSTRAINTS;

/* Drop test Tables */

DROP TABLE test_data;
DROP TABLE test_data_child;
DROP TABLE test_data_main;
DROP TABLE test_tree;


/* Drop cms Tables */

DROP TABLE cms_article_data;
DROP TABLE cms_article;
DROP TABLE cms_comment;
DROP TABLE cms_link;
DROP TABLE cms_category;
DROP TABLE cms_guestbook;
DROP TABLE cms_site;


/*Table structure for table `ACT_GE_BYTEARRAY` */


create table ACT_GE_PROPERTY (
    NAME_ NVARCHAR2(64),
    VALUE_ NVARCHAR2(300),
    REV_ INTEGER,
    primary key (NAME_)
);

insert into ACT_GE_PROPERTY
values ('schema.version', '5.21.0.0', 1);

insert into ACT_GE_PROPERTY
values ('schema.history', 'create(5.21.0.0)', 1);

insert into ACT_GE_PROPERTY
values ('next.dbid', '1', 1);

create table ACT_GE_BYTEARRAY (
    ID_ NVARCHAR2(64),
    REV_ INTEGER,
    NAME_ NVARCHAR2(255),
    DEPLOYMENT_ID_ NVARCHAR2(64),
    BYTES_ BLOB,
    GENERATED_ NUMBER(1,0) CHECK (GENERATED_ IN (1,0)),
    primary key (ID_)
);

create table ACT_RE_DEPLOYMENT (
    ID_ NVARCHAR2(64),
    NAME_ NVARCHAR2(255),
    CATEGORY_ NVARCHAR2(255),
    TENANT_ID_ NVARCHAR2(255) DEFAULT '',
    DEPLOY_TIME_ TIMESTAMP(6),
    primary key (ID_)
);

create table ACT_RE_MODEL (
    ID_ NVARCHAR2(64) not null,
    REV_ INTEGER,
    NAME_ NVARCHAR2(255),
    KEY_ NVARCHAR2(255),
    CATEGORY_ NVARCHAR2(255),
    CREATE_TIME_ TIMESTAMP(6),
    LAST_UPDATE_TIME_ TIMESTAMP(6),
    VERSION_ INTEGER,
    META_INFO_ NVARCHAR2(2000),
    DEPLOYMENT_ID_ NVARCHAR2(64),
    EDITOR_SOURCE_VALUE_ID_ NVARCHAR2(64),
    EDITOR_SOURCE_EXTRA_VALUE_ID_ NVARCHAR2(64),
    TENANT_ID_ NVARCHAR2(255) DEFAULT '',
    primary key (ID_)
);

create table ACT_RU_EXECUTION (
    ID_ NVARCHAR2(64),
    REV_ INTEGER,
    PROC_INST_ID_ NVARCHAR2(64),
    BUSINESS_KEY_ NVARCHAR2(255),
    PARENT_ID_ NVARCHAR2(64),
    PROC_DEF_ID_ NVARCHAR2(64),
    SUPER_EXEC_ NVARCHAR2(64),
    ACT_ID_ NVARCHAR2(255),
    IS_ACTIVE_ NUMBER(1,0) CHECK (IS_ACTIVE_ IN (1,0)),
    IS_CONCURRENT_ NUMBER(1,0) CHECK (IS_CONCURRENT_ IN (1,0)),
    IS_SCOPE_ NUMBER(1,0) CHECK (IS_SCOPE_ IN (1,0)),
    IS_EVENT_SCOPE_ NUMBER(1,0) CHECK (IS_EVENT_SCOPE_ IN (1,0)),
    SUSPENSION_STATE_ INTEGER,
    CACHED_ENT_STATE_ INTEGER,
    TENANT_ID_ NVARCHAR2(255) DEFAULT '',
    NAME_ NVARCHAR2(255),
    LOCK_TIME_ TIMESTAMP(6),
    primary key (ID_)
);

create table ACT_RU_JOB (
    ID_ NVARCHAR2(64) NOT NULL,
    REV_ INTEGER,
    TYPE_ NVARCHAR2(255) NOT NULL,
    LOCK_EXP_TIME_ TIMESTAMP(6),
    LOCK_OWNER_ NVARCHAR2(255),
    EXCLUSIVE_ NUMBER(1,0) CHECK (EXCLUSIVE_ IN (1,0)),
    EXECUTION_ID_ NVARCHAR2(64),
    PROCESS_INSTANCE_ID_ NVARCHAR2(64),
    PROC_DEF_ID_ NVARCHAR2(64),
    RETRIES_ INTEGER,
    EXCEPTION_STACK_ID_ NVARCHAR2(64),
    EXCEPTION_MSG_ NVARCHAR2(2000),
    DUEDATE_ TIMESTAMP(6),
    REPEAT_ NVARCHAR2(255),
    HANDLER_TYPE_ NVARCHAR2(255),
    HANDLER_CFG_ NVARCHAR2(2000),
    TENANT_ID_ NVARCHAR2(255) DEFAULT '',
    primary key (ID_)
);

create table ACT_RE_PROCDEF (
    ID_ NVARCHAR2(64) NOT NULL,
    REV_ INTEGER,
    CATEGORY_ NVARCHAR2(255),
    NAME_ NVARCHAR2(255),
    KEY_ NVARCHAR2(255) NOT NULL,
    VERSION_ INTEGER NOT NULL,
    DEPLOYMENT_ID_ NVARCHAR2(64),
    RESOURCE_NAME_ NVARCHAR2(2000),
    DGRM_RESOURCE_NAME_ varchar(4000),
    DESCRIPTION_ NVARCHAR2(2000),
    HAS_START_FORM_KEY_ NUMBER(1,0) CHECK (HAS_START_FORM_KEY_ IN (1,0)),
    HAS_GRAPHICAL_NOTATION_ NUMBER(1,0) CHECK (HAS_GRAPHICAL_NOTATION_ IN (1,0)),
    SUSPENSION_STATE_ INTEGER,
    TENANT_ID_ NVARCHAR2(255) DEFAULT '',
    primary key (ID_)
);

create table ACT_RU_TASK (
    ID_ NVARCHAR2(64),
    REV_ INTEGER,
    EXECUTION_ID_ NVARCHAR2(64),
    PROC_INST_ID_ NVARCHAR2(64),
    PROC_DEF_ID_ NVARCHAR2(64),
    NAME_ NVARCHAR2(255),
    PARENT_TASK_ID_ NVARCHAR2(64),
    DESCRIPTION_ NVARCHAR2(2000),
    TASK_DEF_KEY_ NVARCHAR2(255),
    OWNER_ NVARCHAR2(255),
    ASSIGNEE_ NVARCHAR2(255),
    DELEGATION_ NVARCHAR2(64),
    PRIORITY_ INTEGER,
    CREATE_TIME_ TIMESTAMP(6),
    DUE_DATE_ TIMESTAMP(6),
    CATEGORY_ NVARCHAR2(255),
    SUSPENSION_STATE_ INTEGER,
    TENANT_ID_ NVARCHAR2(255) DEFAULT '',
    FORM_KEY_ NVARCHAR2(255),
    primary key (ID_)
);

create table ACT_RU_IDENTITYLINK (
    ID_ NVARCHAR2(64),
    REV_ INTEGER,
    GROUP_ID_ NVARCHAR2(255),
    TYPE_ NVARCHAR2(255),
    USER_ID_ NVARCHAR2(255),
    TASK_ID_ NVARCHAR2(64),
    PROC_INST_ID_ NVARCHAR2(64),
    PROC_DEF_ID_ NVARCHAR2(64),
    primary key (ID_)
);

create table ACT_RU_VARIABLE (
    ID_ NVARCHAR2(64) not null,
    REV_ INTEGER,
    TYPE_ NVARCHAR2(255) not null,
    NAME_ NVARCHAR2(255) not null,
    EXECUTION_ID_ NVARCHAR2(64),
    PROC_INST_ID_ NVARCHAR2(64),
    TASK_ID_ NVARCHAR2(64),
    BYTEARRAY_ID_ NVARCHAR2(64),
    DOUBLE_ NUMBER(*,10),
    LONG_ NUMBER(19,0),
    TEXT_ NVARCHAR2(2000),
    TEXT2_ NVARCHAR2(2000),
    primary key (ID_)
);

create table ACT_RU_EVENT_SUBSCR (
    ID_ NVARCHAR2(64) not null,
    REV_ integer,
    EVENT_TYPE_ NVARCHAR2(255) not null,
    EVENT_NAME_ NVARCHAR2(255),
    EXECUTION_ID_ NVARCHAR2(64),
    PROC_INST_ID_ NVARCHAR2(64),
    ACTIVITY_ID_ NVARCHAR2(64),
    CONFIGURATION_ NVARCHAR2(255),
    CREATED_ TIMESTAMP(6) not null,
    PROC_DEF_ID_ NVARCHAR2(64),
    TENANT_ID_ NVARCHAR2(255) DEFAULT '',
    primary key (ID_)
);

create table ACT_EVT_LOG (
    LOG_NR_ NUMBER(19),
    TYPE_ NVARCHAR2(64),
    PROC_DEF_ID_ NVARCHAR2(64),
    PROC_INST_ID_ NVARCHAR2(64),
    EXECUTION_ID_ NVARCHAR2(64),
    TASK_ID_ NVARCHAR2(64),
    TIME_STAMP_ TIMESTAMP(6) not null,
    USER_ID_ NVARCHAR2(255),
    DATA_ BLOB,
    LOCK_OWNER_ NVARCHAR2(255),
    LOCK_TIME_ TIMESTAMP(6) null,
    IS_PROCESSED_ NUMBER(3) default 0,
    primary key (LOG_NR_)
);

create sequence act_evt_log_seq;

create table ACT_PROCDEF_INFO (
	ID_ NVARCHAR2(64) not null,
    PROC_DEF_ID_ NVARCHAR2(64) not null,
    REV_ integer,
    INFO_JSON_ID_ NVARCHAR2(64),
    primary key (ID_)
);

create index ACT_IDX_EXEC_BUSKEY on ACT_RU_EXECUTION(BUSINESS_KEY_);
create index ACT_IDX_TASK_CREATE on ACT_RU_TASK(CREATE_TIME_);
create index ACT_IDX_IDENT_LNK_USER on ACT_RU_IDENTITYLINK(USER_ID_);
create index ACT_IDX_IDENT_LNK_GROUP on ACT_RU_IDENTITYLINK(GROUP_ID_);
create index ACT_IDX_EVENT_SUBSCR_CONFIG_ on ACT_RU_EVENT_SUBSCR(CONFIGURATION_);
create index ACT_IDX_VARIABLE_TASK_ID on ACT_RU_VARIABLE(TASK_ID_);

create index ACT_IDX_BYTEAR_DEPL on ACT_GE_BYTEARRAY(DEPLOYMENT_ID_);
alter table ACT_GE_BYTEARRAY
    add constraint ACT_FK_BYTEARR_DEPL
    foreign key (DEPLOYMENT_ID_) 
    references ACT_RE_DEPLOYMENT (ID_);

alter table ACT_RE_PROCDEF
    add constraint ACT_UNIQ_PROCDEF
    unique (KEY_,VERSION_, TENANT_ID_);
    
create index ACT_IDX_EXE_PROCINST on ACT_RU_EXECUTION(PROC_INST_ID_);
alter table ACT_RU_EXECUTION
    add constraint ACT_FK_EXE_PROCINST
    foreign key (PROC_INST_ID_) 
    references ACT_RU_EXECUTION (ID_);

create index ACT_IDX_EXE_PARENT on ACT_RU_EXECUTION(PARENT_ID_);
alter table ACT_RU_EXECUTION
    add constraint ACT_FK_EXE_PARENT
    foreign key (PARENT_ID_) 
    references ACT_RU_EXECUTION (ID_);
    
create index ACT_IDX_EXE_SUPER on ACT_RU_EXECUTION(SUPER_EXEC_);
alter table ACT_RU_EXECUTION
    add constraint ACT_FK_EXE_SUPER
    foreign key (SUPER_EXEC_) 
    references ACT_RU_EXECUTION (ID_);
    
create index ACT_IDX_EXE_PROCDEF on ACT_RU_EXECUTION(PROC_DEF_ID_);
alter table ACT_RU_EXECUTION
    add constraint ACT_FK_EXE_PROCDEF 
    foreign key (PROC_DEF_ID_) 
    references ACT_RE_PROCDEF (ID_);    

create index ACT_IDX_TSKASS_TASK on ACT_RU_IDENTITYLINK(TASK_ID_);
alter table ACT_RU_IDENTITYLINK
    add constraint ACT_FK_TSKASS_TASK
    foreign key (TASK_ID_) 
    references ACT_RU_TASK (ID_);

create index ACT_IDX_ATHRZ_PROCEDEF  on ACT_RU_IDENTITYLINK(PROC_DEF_ID_);
alter table ACT_RU_IDENTITYLINK
    add constraint ACT_FK_ATHRZ_PROCEDEF
    foreign key (PROC_DEF_ID_) 
    references ACT_RE_PROCDEF (ID_);
    
create index ACT_IDX_IDL_PROCINST on ACT_RU_IDENTITYLINK(PROC_INST_ID_);
alter table ACT_RU_IDENTITYLINK
    add constraint ACT_FK_IDL_PROCINST
    foreign key (PROC_INST_ID_) 
    references ACT_RU_EXECUTION (ID_);    

create index ACT_IDX_TASK_EXEC on ACT_RU_TASK(EXECUTION_ID_);
alter table ACT_RU_TASK
    add constraint ACT_FK_TASK_EXE
    foreign key (EXECUTION_ID_)
    references ACT_RU_EXECUTION (ID_);
    
create index ACT_IDX_TASK_PROCINST on ACT_RU_TASK(PROC_INST_ID_);
alter table ACT_RU_TASK
    add constraint ACT_FK_TASK_PROCINST
    foreign key (PROC_INST_ID_)
    references ACT_RU_EXECUTION (ID_);
    
create index ACT_IDX_TASK_PROCDEF on ACT_RU_TASK(PROC_DEF_ID_);
alter table ACT_RU_TASK
  add constraint ACT_FK_TASK_PROCDEF
  foreign key (PROC_DEF_ID_)
  references ACT_RE_PROCDEF (ID_);
  
create index ACT_IDX_VAR_EXE on ACT_RU_VARIABLE(EXECUTION_ID_);
alter table ACT_RU_VARIABLE 
    add constraint ACT_FK_VAR_EXE
    foreign key (EXECUTION_ID_) 
    references ACT_RU_EXECUTION (ID_);

create index ACT_IDX_VAR_PROCINST on ACT_RU_VARIABLE(PROC_INST_ID_);
alter table ACT_RU_VARIABLE
    add constraint ACT_FK_VAR_PROCINST
    foreign key (PROC_INST_ID_)
    references ACT_RU_EXECUTION(ID_);

create index ACT_IDX_VAR_BYTEARRAY on ACT_RU_VARIABLE(BYTEARRAY_ID_);
alter table ACT_RU_VARIABLE 
    add constraint ACT_FK_VAR_BYTEARRAY 
    foreign key (BYTEARRAY_ID_) 
    references ACT_GE_BYTEARRAY (ID_);

create index ACT_IDX_JOB_EXCEPTION on ACT_RU_JOB(EXCEPTION_STACK_ID_);
alter table ACT_RU_JOB 
    add constraint ACT_FK_JOB_EXCEPTION
    foreign key (EXCEPTION_STACK_ID_) 
    references ACT_GE_BYTEARRAY (ID_);
    
create index ACT_IDX_EVENT_SUBSCR on ACT_RU_EVENT_SUBSCR(EXECUTION_ID_);
alter table ACT_RU_EVENT_SUBSCR
    add constraint ACT_FK_EVENT_EXEC
    foreign key (EXECUTION_ID_)
    references ACT_RU_EXECUTION(ID_);

create index ACT_IDX_MODEL_SOURCE on ACT_RE_MODEL(EDITOR_SOURCE_VALUE_ID_);
alter table ACT_RE_MODEL 
    add constraint ACT_FK_MODEL_SOURCE 
    foreign key (EDITOR_SOURCE_VALUE_ID_) 
    references ACT_GE_BYTEARRAY (ID_);

create index ACT_IDX_MODEL_SOURCE_EXTRA on ACT_RE_MODEL(EDITOR_SOURCE_EXTRA_VALUE_ID_);
alter table ACT_RE_MODEL 
    add constraint ACT_FK_MODEL_SOURCE_EXTRA 
    foreign key (EDITOR_SOURCE_EXTRA_VALUE_ID_) 
    references ACT_GE_BYTEARRAY (ID_);
    
create index ACT_IDX_MODEL_DEPLOYMENT on ACT_RE_MODEL(DEPLOYMENT_ID_);    
alter table ACT_RE_MODEL 
    add constraint ACT_FK_MODEL_DEPLOYMENT 
    foreign key (DEPLOYMENT_ID_) 
    references ACT_RE_DEPLOYMENT (ID_);        

create index ACT_IDX_PROCDEF_INFO_JSON on ACT_PROCDEF_INFO(INFO_JSON_ID_);
alter table ACT_PROCDEF_INFO 
    add constraint ACT_FK_INFO_JSON_BA 
    foreign key (INFO_JSON_ID_) 
    references ACT_GE_BYTEARRAY (ID_);

create index ACT_IDX_PROCDEF_INFO_PROC on ACT_PROCDEF_INFO(PROC_DEF_ID_);
alter table ACT_PROCDEF_INFO 
    add constraint ACT_FK_INFO_PROCDEF 
    foreign key (PROC_DEF_ID_) 
    references ACT_RE_PROCDEF (ID_);
    
alter table ACT_PROCDEF_INFO
    add constraint ACT_UNIQ_INFO_PROCDEF
    unique (PROC_DEF_ID_);
	

/*Data for the table `act_hi_varinst` */

create table ACT_HI_PROCINST (
    ID_ NVARCHAR2(64) not null,
    PROC_INST_ID_ NVARCHAR2(64) not null,
    BUSINESS_KEY_ NVARCHAR2(255),
    PROC_DEF_ID_ NVARCHAR2(64) not null,
    START_TIME_ TIMESTAMP(6) not null,
    END_TIME_ TIMESTAMP(6),
    DURATION_ NUMBER(19,0),
    START_USER_ID_ NVARCHAR2(255),
    START_ACT_ID_ NVARCHAR2(255),
    END_ACT_ID_ NVARCHAR2(255),
    SUPER_PROCESS_INSTANCE_ID_ NVARCHAR2(64),
    DELETE_REASON_ NVARCHAR2(2000),
    TENANT_ID_ NVARCHAR2(255) default '',
    NAME_ NVARCHAR2(255),
    primary key (ID_),
    unique (PROC_INST_ID_)
);

create table ACT_HI_ACTINST (
    ID_ NVARCHAR2(64) not null,
    PROC_DEF_ID_ NVARCHAR2(64) not null,
    PROC_INST_ID_ NVARCHAR2(64) not null,
    EXECUTION_ID_ NVARCHAR2(64) not null,
    ACT_ID_ NVARCHAR2(255) not null,
    TASK_ID_ NVARCHAR2(64),
    CALL_PROC_INST_ID_ NVARCHAR2(64),
    ACT_NAME_ NVARCHAR2(255),
    ACT_TYPE_ NVARCHAR2(255) not null,
    ASSIGNEE_ NVARCHAR2(255),
    START_TIME_ TIMESTAMP(6) not null,
    END_TIME_ TIMESTAMP(6),
    DURATION_ NUMBER(19,0),
    TENANT_ID_ NVARCHAR2(255) default '',
    primary key (ID_)
);

create table ACT_HI_TASKINST (
    ID_ NVARCHAR2(64) not null,
    PROC_DEF_ID_ NVARCHAR2(64),
    TASK_DEF_KEY_ NVARCHAR2(255),
    PROC_INST_ID_ NVARCHAR2(64),
    EXECUTION_ID_ NVARCHAR2(64),
    PARENT_TASK_ID_ NVARCHAR2(64),
    NAME_ NVARCHAR2(255),
    DESCRIPTION_ NVARCHAR2(2000),
    OWNER_ NVARCHAR2(255),
    ASSIGNEE_ NVARCHAR2(255),
    START_TIME_ TIMESTAMP(6) not null,
    CLAIM_TIME_ TIMESTAMP(6),
    END_TIME_ TIMESTAMP(6),
    DURATION_ NUMBER(19,0),
    DELETE_REASON_ NVARCHAR2(2000),
    PRIORITY_ INTEGER,
    DUE_DATE_ TIMESTAMP(6),
    FORM_KEY_ NVARCHAR2(255),
    CATEGORY_ NVARCHAR2(255),
    TENANT_ID_ NVARCHAR2(255) default '',
    primary key (ID_)
);

create table ACT_HI_VARINST (
    ID_ NVARCHAR2(64) not null,
    PROC_INST_ID_ NVARCHAR2(64),
    EXECUTION_ID_ NVARCHAR2(64),
    TASK_ID_ NVARCHAR2(64),
    NAME_ NVARCHAR2(255) not null,
    VAR_TYPE_ NVARCHAR2(100),
    REV_ INTEGER,
    BYTEARRAY_ID_ NVARCHAR2(64),
    DOUBLE_ NUMBER(*,10),
    LONG_ NUMBER(19,0),
    TEXT_ NVARCHAR2(2000),
    TEXT2_ NVARCHAR2(2000),
    CREATE_TIME_ TIMESTAMP(6),
    LAST_UPDATED_TIME_ TIMESTAMP(6),
    primary key (ID_)
);

create table ACT_HI_DETAIL (
    ID_ NVARCHAR2(64) not null,
    TYPE_ NVARCHAR2(255) not null,
    PROC_INST_ID_ NVARCHAR2(64),
    EXECUTION_ID_ NVARCHAR2(64),
    TASK_ID_ NVARCHAR2(64),
    ACT_INST_ID_ NVARCHAR2(64),
    NAME_ NVARCHAR2(255) not null,
    VAR_TYPE_ NVARCHAR2(64),
    REV_ INTEGER,
    TIME_ TIMESTAMP(6) not null,
    BYTEARRAY_ID_ NVARCHAR2(64),
    DOUBLE_ NUMBER(*,10),
    LONG_ NUMBER(19,0),
    TEXT_ NVARCHAR2(2000),
    TEXT2_ NVARCHAR2(2000),
    primary key (ID_)
);

create table ACT_HI_COMMENT (
    ID_ NVARCHAR2(64) not null,
    TYPE_ NVARCHAR2(255),
    TIME_ TIMESTAMP(6) not null,
    USER_ID_ NVARCHAR2(255),
    TASK_ID_ NVARCHAR2(64),
    PROC_INST_ID_ NVARCHAR2(64),
    ACTION_ NVARCHAR2(255),
    MESSAGE_ NVARCHAR2(2000),
    FULL_MSG_ BLOB,
    primary key (ID_)
);

create table ACT_HI_ATTACHMENT (
    ID_ NVARCHAR2(64) not null,
    REV_ INTEGER,
    USER_ID_ NVARCHAR2(255),
    NAME_ NVARCHAR2(255),
    DESCRIPTION_ NVARCHAR2(2000),
    TYPE_ NVARCHAR2(255),
    TASK_ID_ NVARCHAR2(64),
    PROC_INST_ID_ NVARCHAR2(64),
    URL_ NVARCHAR2(2000),
    CONTENT_ID_ NVARCHAR2(64),
    TIME_ TIMESTAMP(6),
    primary key (ID_)
);

create table ACT_HI_IDENTITYLINK (
    ID_ NVARCHAR2(64),
    GROUP_ID_ NVARCHAR2(255),
    TYPE_ NVARCHAR2(255),
    USER_ID_ NVARCHAR2(255),
    TASK_ID_ NVARCHAR2(64),
    PROC_INST_ID_ NVARCHAR2(64),
    primary key (ID_)
);

create index ACT_IDX_HI_PRO_INST_END on ACT_HI_PROCINST(END_TIME_);
create index ACT_IDX_HI_PRO_I_BUSKEY on ACT_HI_PROCINST(BUSINESS_KEY_);
create index ACT_IDX_HI_ACT_INST_START on ACT_HI_ACTINST(START_TIME_);
create index ACT_IDX_HI_ACT_INST_END on ACT_HI_ACTINST(END_TIME_);
create index ACT_IDX_HI_DETAIL_PROC_INST on ACT_HI_DETAIL(PROC_INST_ID_);
create index ACT_IDX_HI_DETAIL_ACT_INST on ACT_HI_DETAIL(ACT_INST_ID_);
create index ACT_IDX_HI_DETAIL_TIME on ACT_HI_DETAIL(TIME_);
create index ACT_IDX_HI_DETAIL_NAME on ACT_HI_DETAIL(NAME_);
create index ACT_IDX_HI_DETAIL_TASK_ID on ACT_HI_DETAIL(TASK_ID_);
create index ACT_IDX_HI_PROCVAR_PROC_INST on ACT_HI_VARINST(PROC_INST_ID_);
create index ACT_IDX_HI_PROCVAR_NAME_TYPE on ACT_HI_VARINST(NAME_, VAR_TYPE_);
create index ACT_IDX_HI_PROCVAR_TASK_ID on ACT_HI_VARINST(TASK_ID_);
create index ACT_IDX_HI_IDENT_LNK_USER on ACT_HI_IDENTITYLINK(USER_ID_);
create index ACT_IDX_HI_IDENT_LNK_TASK on ACT_HI_IDENTITYLINK(TASK_ID_);
create index ACT_IDX_HI_IDENT_LNK_PROCINST on ACT_HI_IDENTITYLINK(PROC_INST_ID_);

create index ACT_IDX_HI_ACT_INST_PROCINST on ACT_HI_ACTINST(PROC_INST_ID_, ACT_ID_);
create index ACT_IDX_HI_ACT_INST_EXEC on ACT_HI_ACTINST(EXECUTION_ID_, ACT_ID_);
create index ACT_IDX_HI_TASK_INST_PROCINST on ACT_HI_TASKINST(PROC_INST_ID_);


create table ACT_ID_GROUP (
    ID_ NVARCHAR2(64),
    REV_ INTEGER,
    NAME_ NVARCHAR2(255),
    TYPE_ NVARCHAR2(255),
    primary key (ID_)
);

create table ACT_ID_MEMBERSHIP (
    USER_ID_ NVARCHAR2(64),
    GROUP_ID_ NVARCHAR2(64),
    primary key (USER_ID_, GROUP_ID_)
);

create table ACT_ID_USER (
    ID_ NVARCHAR2(64),
    REV_ INTEGER,
    FIRST_ NVARCHAR2(255),
    LAST_ NVARCHAR2(255),
    EMAIL_ NVARCHAR2(255),
    PWD_ NVARCHAR2(255),
    PICTURE_ID_ NVARCHAR2(64),
    primary key (ID_)
);

create table ACT_ID_INFO (
    ID_ NVARCHAR2(64),
    REV_ INTEGER,
    USER_ID_ NVARCHAR2(64),
    TYPE_ NVARCHAR2(64),
    KEY_ NVARCHAR2(255),
    VALUE_ NVARCHAR2(255),
    PASSWORD_ BLOB,
    PARENT_ID_ NVARCHAR2(255),
    primary key (ID_)
);

create index ACT_IDX_MEMB_GROUP on ACT_ID_MEMBERSHIP(GROUP_ID_);
alter table ACT_ID_MEMBERSHIP 
    add constraint ACT_FK_MEMB_GROUP 
    foreign key (GROUP_ID_) 
    references ACT_ID_GROUP (ID_);

create index ACT_IDX_MEMB_USER on ACT_ID_MEMBERSHIP(USER_ID_);
alter table ACT_ID_MEMBERSHIP 
    add constraint ACT_FK_MEMB_USER
    foreign key (USER_ID_) 
    references ACT_ID_USER (ID_);


/*Table structure for table `cms_article` */


CREATE TABLE cms_article
(
	id varchar2(64) NOT NULL,
	category_id varchar2(64) NOT NULL,
	title varchar2(255) NOT NULL,
	link varchar2(255),
	color varchar2(50),
	image varchar2(255),
	keywords varchar2(255),
	description varchar2(255),
	weight number(10,0) DEFAULT 0,
	weight_date timestamp,
	hits number(10,0) DEFAULT 0,
	posid varchar2(10),
	custom_content_view varchar2(255),
	view_config clob,
	create_by varchar2(64),
	create_date timestamp,
	update_by varchar2(64),
	update_date timestamp,
	remarks varchar2(255),
	del_flag char(1) DEFAULT '0' NOT NULL,
	PRIMARY KEY (id)
);

COMMENT ON TABLE cms_article IS '文章表';
COMMENT ON COLUMN cms_article.id IS '编号';
COMMENT ON COLUMN cms_article.category_id IS '栏目编号';
COMMENT ON COLUMN cms_article.title IS '标题';
COMMENT ON COLUMN cms_article.link IS '文章链接';
COMMENT ON COLUMN cms_article.color IS '标题颜色';
COMMENT ON COLUMN cms_article.image IS '文章图片';
COMMENT ON COLUMN cms_article.keywords IS '关键字';
COMMENT ON COLUMN cms_article.description IS '描述、摘要';
COMMENT ON COLUMN cms_article.weight IS '权重，越大越靠前';
COMMENT ON COLUMN cms_article.weight_date IS '权重期限';
COMMENT ON COLUMN cms_article.hits IS '点击数';
COMMENT ON COLUMN cms_article.posid IS '推荐位，多选';
COMMENT ON COLUMN cms_article.custom_content_view IS '自定义内容视图';
COMMENT ON COLUMN cms_article.view_config IS '视图配置';
COMMENT ON COLUMN cms_article.create_by IS '创建者';
COMMENT ON COLUMN cms_article.create_date IS '创建时间';
COMMENT ON COLUMN cms_article.update_by IS '更新者';
COMMENT ON COLUMN cms_article.update_date IS '更新时间';
COMMENT ON COLUMN cms_article.remarks IS '备注信息';
COMMENT ON COLUMN cms_article.del_flag IS '删除标记';



/*Data for the table `cms_article` */

insert  into cms_article(id,category_id,title,link,color,image,keywords,description,weight,weight_date,hits,posid,custom_content_view,view_config,create_by,create_date,update_by,update_date,remarks,del_flag) values ('1','3','文章标题标题标题标题',NULL,'green',NULL,'关键字1,关键字2',NULL,0,NULL,0,NULL,NULL,NULL,'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0');
 insert  into cms_article(id,category_id,title,link,color,image,keywords,description,weight,weight_date,hits,posid,custom_content_view,view_config,create_by,create_date,update_by,update_date,remarks,del_flag) values ('10','4','文章标题标题标题标题',NULL,NULL,NULL,'关键字1,关键字2',NULL,0,NULL,0,NULL,NULL,NULL,'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0');
 insert  into cms_article(id,category_id,title,link,color,image,keywords,description,weight,weight_date,hits,posid,custom_content_view,view_config,create_by,create_date,update_by,update_date,remarks,del_flag) values ('11','5','文章标题标题标题标题',NULL,NULL,NULL,'关键字1,关键字2',NULL,0,NULL,0,NULL,NULL,NULL,'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0');
 insert  into cms_article(id,category_id,title,link,color,image,keywords,description,weight,weight_date,hits,posid,custom_content_view,view_config,create_by,create_date,update_by,update_date,remarks,del_flag) values ('12','5','文章标题标题标题标题',NULL,NULL,NULL,'关键字1,关键字2',NULL,0,NULL,0,NULL,NULL,NULL,'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0');
 insert  into cms_article(id,category_id,title,link,color,image,keywords,description,weight,weight_date,hits,posid,custom_content_view,view_config,create_by,create_date,update_by,update_date,remarks,del_flag) values ('13','5','文章标题标题标题标题',NULL,NULL,NULL,'关键字1,关键字2',NULL,0,NULL,0,NULL,NULL,NULL,'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0');
 insert  into cms_article(id,category_id,title,link,color,image,keywords,description,weight,weight_date,hits,posid,custom_content_view,view_config,create_by,create_date,update_by,update_date,remarks,del_flag) values ('14','7','文章标题标题标题标题',NULL,NULL,NULL,'关键字1,关键字2',NULL,0,NULL,0,NULL,NULL,NULL,'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0');
 insert  into cms_article(id,category_id,title,link,color,image,keywords,description,weight,weight_date,hits,posid,custom_content_view,view_config,create_by,create_date,update_by,update_date,remarks,del_flag) values ('15','7','文章标题标题标题标题',NULL,NULL,NULL,'关键字1,关键字2',NULL,0,NULL,0,NULL,NULL,NULL,'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0');
 insert  into cms_article(id,category_id,title,link,color,image,keywords,description,weight,weight_date,hits,posid,custom_content_view,view_config,create_by,create_date,update_by,update_date,remarks,del_flag) values ('16','7','文章标题标题标题标题',NULL,NULL,NULL,'关键字1,关键字2',NULL,0,NULL,0,NULL,NULL,NULL,'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0');
 insert  into cms_article(id,category_id,title,link,color,image,keywords,description,weight,weight_date,hits,posid,custom_content_view,view_config,create_by,create_date,update_by,update_date,remarks,del_flag) values ('17','7','文章标题标题标题标题',NULL,NULL,NULL,'关键字1,关键字2',NULL,0,NULL,0,NULL,NULL,NULL,'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0');
 insert  into cms_article(id,category_id,title,link,color,image,keywords,description,weight,weight_date,hits,posid,custom_content_view,view_config,create_by,create_date,update_by,update_date,remarks,del_flag) values ('18','8','文章标题标题标题标题',NULL,NULL,NULL,'关键字1,关键字2',NULL,0,NULL,0,NULL,NULL,NULL,'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0');
 insert  into cms_article(id,category_id,title,link,color,image,keywords,description,weight,weight_date,hits,posid,custom_content_view,view_config,create_by,create_date,update_by,update_date,remarks,del_flag) values ('19','8','文章标题标题标题标题',NULL,NULL,NULL,'关键字1,关键字2',NULL,0,NULL,0,NULL,NULL,NULL,'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0');
 insert  into cms_article(id,category_id,title,link,color,image,keywords,description,weight,weight_date,hits,posid,custom_content_view,view_config,create_by,create_date,update_by,update_date,remarks,del_flag) values ('2','3','文章标题标题标题标题',NULL,'red',NULL,'关键字1,关键字2',NULL,0,NULL,0,NULL,NULL,NULL,'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0');
 insert  into cms_article(id,category_id,title,link,color,image,keywords,description,weight,weight_date,hits,posid,custom_content_view,view_config,create_by,create_date,update_by,update_date,remarks,del_flag) values ('20','8','文章标题标题标题标题',NULL,NULL,NULL,'关键字1,关键字2',NULL,0,NULL,0,NULL,NULL,NULL,'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0');
 insert  into cms_article(id,category_id,title,link,color,image,keywords,description,weight,weight_date,hits,posid,custom_content_view,view_config,create_by,create_date,update_by,update_date,remarks,del_flag) values ('21','8','文章标题标题标题标题',NULL,NULL,NULL,'关键字1,关键字2',NULL,0,NULL,0,NULL,NULL,NULL,'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0');
 insert  into cms_article(id,category_id,title,link,color,image,keywords,description,weight,weight_date,hits,posid,custom_content_view,view_config,create_by,create_date,update_by,update_date,remarks,del_flag) values ('22','9','文章标题标题标题标题',NULL,NULL,NULL,'关键字1,关键字2',NULL,0,NULL,0,NULL,NULL,NULL,'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0');
 insert  into cms_article(id,category_id,title,link,color,image,keywords,description,weight,weight_date,hits,posid,custom_content_view,view_config,create_by,create_date,update_by,update_date,remarks,del_flag) values ('23','9','文章标题标题标题标题',NULL,NULL,NULL,'关键字1,关键字2',NULL,0,NULL,0,NULL,NULL,NULL,'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0');
 insert  into cms_article(id,category_id,title,link,color,image,keywords,description,weight,weight_date,hits,posid,custom_content_view,view_config,create_by,create_date,update_by,update_date,remarks,del_flag) values ('24','9','文章标题标题标题标题',NULL,NULL,NULL,'关键字1,关键字2',NULL,0,NULL,0,NULL,NULL,NULL,'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0');
 insert  into cms_article(id,category_id,title,link,color,image,keywords,description,weight,weight_date,hits,posid,custom_content_view,view_config,create_by,create_date,update_by,update_date,remarks,del_flag) values ('25','9','文章标题标题标题标题',NULL,NULL,NULL,'关键字1,关键字2',NULL,0,NULL,0,NULL,NULL,NULL,'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0');
 insert  into cms_article(id,category_id,title,link,color,image,keywords,description,weight,weight_date,hits,posid,custom_content_view,view_config,create_by,create_date,update_by,update_date,remarks,del_flag) values ('26','9','文章标题标题标题标题',NULL,NULL,NULL,'关键字1,关键字2',NULL,0,NULL,0,NULL,NULL,NULL,'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0');
 insert  into cms_article(id,category_id,title,link,color,image,keywords,description,weight,weight_date,hits,posid,custom_content_view,view_config,create_by,create_date,update_by,update_date,remarks,del_flag) values ('27','11','文章标题标题标题标题',NULL,NULL,NULL,'关键字1,关键字2',NULL,0,NULL,0,NULL,NULL,NULL,'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0');
 insert  into cms_article(id,category_id,title,link,color,image,keywords,description,weight,weight_date,hits,posid,custom_content_view,view_config,create_by,create_date,update_by,update_date,remarks,del_flag) values ('28','11','文章标题标题标题标题',NULL,NULL,NULL,'关键字1,关键字2',NULL,0,NULL,0,NULL,NULL,NULL,'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0');
 insert  into cms_article(id,category_id,title,link,color,image,keywords,description,weight,weight_date,hits,posid,custom_content_view,view_config,create_by,create_date,update_by,update_date,remarks,del_flag) values ('29','11','文章标题标题标题标题',NULL,NULL,NULL,'关键字1,关键字2',NULL,0,NULL,0,NULL,NULL,NULL,'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0');
 insert  into cms_article(id,category_id,title,link,color,image,keywords,description,weight,weight_date,hits,posid,custom_content_view,view_config,create_by,create_date,update_by,update_date,remarks,del_flag) values ('3','3','文章标题标题标题标题',NULL,NULL,NULL,'关键字1,关键字2',NULL,0,NULL,0,NULL,NULL,NULL,'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0');
 insert  into cms_article(id,category_id,title,link,color,image,keywords,description,weight,weight_date,hits,posid,custom_content_view,view_config,create_by,create_date,update_by,update_date,remarks,del_flag) values ('30','11','文章标题标题标题标题',NULL,NULL,NULL,'关键字1,关键字2',NULL,0,NULL,0,NULL,NULL,NULL,'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0');
 insert  into cms_article(id,category_id,title,link,color,image,keywords,description,weight,weight_date,hits,posid,custom_content_view,view_config,create_by,create_date,update_by,update_date,remarks,del_flag) values ('31','11','文章标题标题标题标题',NULL,NULL,NULL,'关键字1,关键字2',NULL,0,NULL,0,NULL,NULL,NULL,'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0');
 insert  into cms_article(id,category_id,title,link,color,image,keywords,description,weight,weight_date,hits,posid,custom_content_view,view_config,create_by,create_date,update_by,update_date,remarks,del_flag) values ('32','12','文章标题标题标题标题',NULL,NULL,NULL,'关键字1,关键字2',NULL,0,NULL,0,NULL,NULL,NULL,'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0');
 insert  into cms_article(id,category_id,title,link,color,image,keywords,description,weight,weight_date,hits,posid,custom_content_view,view_config,create_by,create_date,update_by,update_date,remarks,del_flag) values ('33','12','文章标题标题标题标题',NULL,NULL,NULL,'关键字1,关键字2',NULL,0,NULL,0,NULL,NULL,NULL,'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0');
 insert  into cms_article(id,category_id,title,link,color,image,keywords,description,weight,weight_date,hits,posid,custom_content_view,view_config,create_by,create_date,update_by,update_date,remarks,del_flag) values ('34','12','文章标题标题标题标题',NULL,NULL,NULL,'关键字1,关键字2',NULL,0,NULL,0,NULL,NULL,NULL,'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0');
 insert  into cms_article(id,category_id,title,link,color,image,keywords,description,weight,weight_date,hits,posid,custom_content_view,view_config,create_by,create_date,update_by,update_date,remarks,del_flag) values ('35','12','文章标题标题标题标题',NULL,NULL,NULL,'关键字1,关键字2',NULL,0,NULL,0,NULL,NULL,NULL,'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0');
 insert  into cms_article(id,category_id,title,link,color,image,keywords,description,weight,weight_date,hits,posid,custom_content_view,view_config,create_by,create_date,update_by,update_date,remarks,del_flag) values ('36','12','文章标题标题标题标题',NULL,NULL,NULL,'关键字1,关键字2',NULL,0,NULL,0,NULL,NULL,NULL,'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0');
 insert  into cms_article(id,category_id,title,link,color,image,keywords,description,weight,weight_date,hits,posid,custom_content_view,view_config,create_by,create_date,update_by,update_date,remarks,del_flag) values ('37','13','文章标题标题标题标题',NULL,NULL,NULL,'关键字1,关键字2',NULL,0,NULL,0,NULL,NULL,NULL,'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0');
 insert  into cms_article(id,category_id,title,link,color,image,keywords,description,weight,weight_date,hits,posid,custom_content_view,view_config,create_by,create_date,update_by,update_date,remarks,del_flag) values ('38','13','文章标题标题标题标题',NULL,NULL,NULL,'关键字1,关键字2',NULL,0,NULL,0,NULL,NULL,NULL,'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0');
 insert  into cms_article(id,category_id,title,link,color,image,keywords,description,weight,weight_date,hits,posid,custom_content_view,view_config,create_by,create_date,update_by,update_date,remarks,del_flag) values ('39','13','文章标题标题标题标题',NULL,NULL,NULL,'关键字1,关键字2',NULL,0,NULL,0,NULL,NULL,NULL,'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0');
 insert  into cms_article(id,category_id,title,link,color,image,keywords,description,weight,weight_date,hits,posid,custom_content_view,view_config,create_by,create_date,update_by,update_date,remarks,del_flag) values ('4','3','文章标题标题标题标题',NULL,'green',NULL,'关键字1,关键字2',NULL,0,NULL,0,NULL,NULL,NULL,'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0');
 insert  into cms_article(id,category_id,title,link,color,image,keywords,description,weight,weight_date,hits,posid,custom_content_view,view_config,create_by,create_date,update_by,update_date,remarks,del_flag) values ('40','13','文章标题标题标题标题',NULL,NULL,NULL,'关键字1,关键字2',NULL,0,NULL,0,NULL,NULL,NULL,'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0');
 insert  into cms_article(id,category_id,title,link,color,image,keywords,description,weight,weight_date,hits,posid,custom_content_view,view_config,create_by,create_date,update_by,update_date,remarks,del_flag) values ('41','14','文章标题标题标题标题',NULL,NULL,NULL,'关键字1,关键字2',NULL,0,NULL,0,NULL,NULL,NULL,'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0');
 insert  into cms_article(id,category_id,title,link,color,image,keywords,description,weight,weight_date,hits,posid,custom_content_view,view_config,create_by,create_date,update_by,update_date,remarks,del_flag) values ('42','14','文章标题标题标题标题',NULL,NULL,NULL,'关键字1,关键字2',NULL,0,NULL,0,NULL,NULL,NULL,'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0');
 insert  into cms_article(id,category_id,title,link,color,image,keywords,description,weight,weight_date,hits,posid,custom_content_view,view_config,create_by,create_date,update_by,update_date,remarks,del_flag) values ('43','14','文章标题标题标题标题',NULL,NULL,NULL,'关键字1,关键字2',NULL,0,NULL,0,NULL,NULL,NULL,'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0');
 insert  into cms_article(id,category_id,title,link,color,image,keywords,description,weight,weight_date,hits,posid,custom_content_view,view_config,create_by,create_date,update_by,update_date,remarks,del_flag) values ('44','14','文章标题标题标题标题',NULL,NULL,NULL,'关键字1,关键字2',NULL,0,NULL,0,NULL,NULL,NULL,'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0');
 insert  into cms_article(id,category_id,title,link,color,image,keywords,description,weight,weight_date,hits,posid,custom_content_view,view_config,create_by,create_date,update_by,update_date,remarks,del_flag) values ('45','14','文章标题标题标题标题',NULL,NULL,NULL,'关键字1,关键字2',NULL,0,NULL,0,NULL,NULL,NULL,'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0');
 insert  into cms_article(id,category_id,title,link,color,image,keywords,description,weight,weight_date,hits,posid,custom_content_view,view_config,create_by,create_date,update_by,update_date,remarks,del_flag) values ('46','15','文章标题标题标题标题',NULL,NULL,NULL,'关键字1,关键字2',NULL,0,NULL,0,NULL,NULL,NULL,'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0');
 insert  into cms_article(id,category_id,title,link,color,image,keywords,description,weight,weight_date,hits,posid,custom_content_view,view_config,create_by,create_date,update_by,update_date,remarks,del_flag) values ('47','15','文章标题标题标题标题',NULL,NULL,NULL,'关键字1,关键字2',NULL,0,NULL,0,NULL,NULL,NULL,'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0');
 insert  into cms_article(id,category_id,title,link,color,image,keywords,description,weight,weight_date,hits,posid,custom_content_view,view_config,create_by,create_date,update_by,update_date,remarks,del_flag) values ('48','15','文章标题标题标题标题',NULL,NULL,NULL,'关键字1,关键字2',NULL,0,NULL,0,NULL,NULL,NULL,'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0');
 insert  into cms_article(id,category_id,title,link,color,image,keywords,description,weight,weight_date,hits,posid,custom_content_view,view_config,create_by,create_date,update_by,update_date,remarks,del_flag) values ('49','16','文章标题标题标题标题',NULL,NULL,NULL,'关键字1,关键字2',NULL,0,NULL,0,NULL,NULL,NULL,'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0');
 insert  into cms_article(id,category_id,title,link,color,image,keywords,description,weight,weight_date,hits,posid,custom_content_view,view_config,create_by,create_date,update_by,update_date,remarks,del_flag) values ('5','3','文章标题标题标题标题',NULL,NULL,NULL,'关键字1,关键字2',NULL,0,NULL,0,NULL,NULL,NULL,'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0');
 insert  into cms_article(id,category_id,title,link,color,image,keywords,description,weight,weight_date,hits,posid,custom_content_view,view_config,create_by,create_date,update_by,update_date,remarks,del_flag) values ('50','17','文章标题标题标题标题',NULL,NULL,NULL,'关键字1,关键字2',NULL,0,NULL,0,NULL,NULL,NULL,'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0');
 insert  into cms_article(id,category_id,title,link,color,image,keywords,description,weight,weight_date,hits,posid,custom_content_view,view_config,create_by,create_date,update_by,update_date,remarks,del_flag) values ('51','17','文章标题标题标题标题',NULL,NULL,NULL,'关键字1,关键字2',NULL,0,NULL,0,NULL,NULL,NULL,'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0');
 insert  into cms_article(id,category_id,title,link,color,image,keywords,description,weight,weight_date,hits,posid,custom_content_view,view_config,create_by,create_date,update_by,update_date,remarks,del_flag) values ('52','26','文章标题标题标题标题',NULL,NULL,NULL,'关键字1,关键字2',NULL,0,NULL,0,NULL,NULL,NULL,'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0');
 insert  into cms_article(id,category_id,title,link,color,image,keywords,description,weight,weight_date,hits,posid,custom_content_view,view_config,create_by,create_date,update_by,update_date,remarks,del_flag) values ('53','26','文章标题标题标题标题',NULL,NULL,NULL,'关键字1,关键字2',NULL,0,NULL,0,NULL,NULL,NULL,'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0');
 insert  into cms_article(id,category_id,title,link,color,image,keywords,description,weight,weight_date,hits,posid,custom_content_view,view_config,create_by,create_date,update_by,update_date,remarks,del_flag) values ('6','3','文章标题标题标题标题',NULL,NULL,NULL,'关键字1,关键字2',NULL,0,NULL,0,NULL,NULL,NULL,'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0');
 insert  into cms_article(id,category_id,title,link,color,image,keywords,description,weight,weight_date,hits,posid,custom_content_view,view_config,create_by,create_date,update_by,update_date,remarks,del_flag) values ('7','4','文章标题标题标题标题',NULL,NULL,NULL,'关键字1,关键字2',NULL,0,NULL,0,NULL,NULL,NULL,'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0');
 insert  into cms_article(id,category_id,title,link,color,image,keywords,description,weight,weight_date,hits,posid,custom_content_view,view_config,create_by,create_date,update_by,update_date,remarks,del_flag) values ('8','4','文章标题标题标题标题',NULL,'blue',NULL,'关键字1,关键字2',NULL,0,NULL,0,NULL,NULL,NULL,'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0');
 insert  into cms_article(id,category_id,title,link,color,image,keywords,description,weight,weight_date,hits,posid,custom_content_view,view_config,create_by,create_date,update_by,update_date,remarks,del_flag) values ('9','4','文章标题标题标题标题',NULL,NULL,NULL,'关键字1,关键字2',NULL,0,NULL,0,NULL,NULL,NULL,'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0');

 commit;
/*Table structure for table `cms_article_data` */

CREATE TABLE cms_article_data
(
	id varchar2(64) NOT NULL,
	content clob,
	copyfrom varchar2(255),
	relation varchar2(255),
	allow_comment char(1),
	PRIMARY KEY (id)
);

COMMENT ON TABLE cms_article_data IS '文章详表';
COMMENT ON COLUMN cms_article_data.id IS '编号';
COMMENT ON COLUMN cms_article_data.content IS '文章内容';
COMMENT ON COLUMN cms_article_data.copyfrom IS '文章来源';
COMMENT ON COLUMN cms_article_data.relation IS '相关文章';
COMMENT ON COLUMN cms_article_data.allow_comment IS '是否允许评论';


/*Data for the table `cms_article_data` */

insert  into cms_article_data(id,content,copyfrom,relation,allow_comment) values ('1','文章内容内容内容内容','来源','1,2,3','1');
 insert  into cms_article_data(id,content,copyfrom,relation,allow_comment) values ('10','文章内容内容内容内容','来源','1,2,3','1');
 insert  into cms_article_data(id,content,copyfrom,relation,allow_comment) values ('11','文章内容内容内容内容','来源','1,2,3','1');
 insert  into cms_article_data(id,content,copyfrom,relation,allow_comment) values ('12','文章内容内容内容内容','来源','1,2,3','1');
 insert  into cms_article_data(id,content,copyfrom,relation,allow_comment) values ('13','文章内容内容内容内容','来源','1,2,3','1');
 insert  into cms_article_data(id,content,copyfrom,relation,allow_comment) values ('14','文章内容内容内容内容','来源','1,2,3','1');
 insert  into cms_article_data(id,content,copyfrom,relation,allow_comment) values ('15','文章内容内容内容内容','来源','1,2,3','1');
 insert  into cms_article_data(id,content,copyfrom,relation,allow_comment) values ('16','文章内容内容内容内容','来源','1,2,3','1');
 insert  into cms_article_data(id,content,copyfrom,relation,allow_comment) values ('17','文章内容内容内容内容','来源','1,2,3','1');
 insert  into cms_article_data(id,content,copyfrom,relation,allow_comment) values ('18','文章内容内容内容内容','来源','1,2,3','1');
 insert  into cms_article_data(id,content,copyfrom,relation,allow_comment) values ('19','文章内容内容内容内容','来源','1,2,3','1');
 insert  into cms_article_data(id,content,copyfrom,relation,allow_comment) values ('2','文章内容内容内容内容','来源','1,2,3','1');
 insert  into cms_article_data(id,content,copyfrom,relation,allow_comment) values ('20','文章内容内容内容内容','来源','1,2,3','1');
 insert  into cms_article_data(id,content,copyfrom,relation,allow_comment) values ('21','文章内容内容内容内容','来源','1,2,3','1');
 insert  into cms_article_data(id,content,copyfrom,relation,allow_comment) values ('22','文章内容内容内容内容','来源','1,2,3','1');
 insert  into cms_article_data(id,content,copyfrom,relation,allow_comment) values ('23','文章内容内容内容内容','来源','1,2,3','1');
 insert  into cms_article_data(id,content,copyfrom,relation,allow_comment) values ('24','文章内容内容内容内容','来源','1,2,3','1');
 insert  into cms_article_data(id,content,copyfrom,relation,allow_comment) values ('25','文章内容内容内容内容','来源','1,2,3','1');
 insert  into cms_article_data(id,content,copyfrom,relation,allow_comment) values ('26','文章内容内容内容内容','来源','1,2,3','1');
 insert  into cms_article_data(id,content,copyfrom,relation,allow_comment) values ('27','文章内容内容内容内容','来源','1,2,3','1');
 insert  into cms_article_data(id,content,copyfrom,relation,allow_comment) values ('28','文章内容内容内容内容','来源','1,2,3','1');
 insert  into cms_article_data(id,content,copyfrom,relation,allow_comment) values ('29','文章内容内容内容内容','来源','1,2,3','1');
 insert  into cms_article_data(id,content,copyfrom,relation,allow_comment) values ('3','文章内容内容内容内容','来源','1,2,3','1');
 insert  into cms_article_data(id,content,copyfrom,relation,allow_comment) values ('30','文章内容内容内容内容','来源','1,2,3','1');
 insert  into cms_article_data(id,content,copyfrom,relation,allow_comment) values ('31','文章内容内容内容内容','来源','1,2,3','1');
 insert  into cms_article_data(id,content,copyfrom,relation,allow_comment) values ('32','文章内容内容内容内容','来源','1,2,3','1');
 insert  into cms_article_data(id,content,copyfrom,relation,allow_comment) values ('33','文章内容内容内容内容','来源','1,2,3','1');
 insert  into cms_article_data(id,content,copyfrom,relation,allow_comment) values ('34','文章内容内容内容内容','来源','1,2,3','1');
 insert  into cms_article_data(id,content,copyfrom,relation,allow_comment) values ('35','文章内容内容内容内容','来源','1,2,3','1');
 insert  into cms_article_data(id,content,copyfrom,relation,allow_comment) values ('36','文章内容内容内容内容','来源','1,2,3','1');
 insert  into cms_article_data(id,content,copyfrom,relation,allow_comment) values ('37','文章内容内容内容内容','来源','1,2,3','1');
 insert  into cms_article_data(id,content,copyfrom,relation,allow_comment) values ('38','文章内容内容内容内容','来源','1,2,3','1');
 insert  into cms_article_data(id,content,copyfrom,relation,allow_comment) values ('39','文章内容内容内容内容','来源','1,2,3','1');
 insert  into cms_article_data(id,content,copyfrom,relation,allow_comment) values ('4','文章内容内容内容内容','来源','1,2,3','1');
 insert  into cms_article_data(id,content,copyfrom,relation,allow_comment) values ('40','文章内容内容内容内容','来源','1,2,3','1');
 insert  into cms_article_data(id,content,copyfrom,relation,allow_comment) values ('41','文章内容内容内容内容','来源','1,2,3','1');
 insert  into cms_article_data(id,content,copyfrom,relation,allow_comment) values ('42','文章内容内容内容内容','来源','1,2,3','1');
 insert  into cms_article_data(id,content,copyfrom,relation,allow_comment) values ('43','文章内容内容内容内容','来源','1,2,3','1');
 insert  into cms_article_data(id,content,copyfrom,relation,allow_comment) values ('44','文章内容内容内容内容','来源','1,2,3','1');
 insert  into cms_article_data(id,content,copyfrom,relation,allow_comment) values ('45','文章内容内容内容内容','来源','1,2,3','1');
 insert  into cms_article_data(id,content,copyfrom,relation,allow_comment) values ('46','文章内容内容内容内容','来源','1,2,3','1');
 insert  into cms_article_data(id,content,copyfrom,relation,allow_comment) values ('47','文章内容内容内容内容','来源','1,2,3','1');
 insert  into cms_article_data(id,content,copyfrom,relation,allow_comment) values ('48','文章内容内容内容内容','来源','1,2,3','1');
 insert  into cms_article_data(id,content,copyfrom,relation,allow_comment) values ('49','文章内容内容内容内容','来源','1,2,3','1');
 insert  into cms_article_data(id,content,copyfrom,relation,allow_comment) values ('5','文章内容内容内容内容','来源','1,2,3','1');
 insert  into cms_article_data(id,content,copyfrom,relation,allow_comment) values ('50','文章内容内容内容内容','来源','1,2,3','1');
 insert  into cms_article_data(id,content,copyfrom,relation,allow_comment) values ('51','文章内容内容内容内容','来源','1,2,3','1');
 insert  into cms_article_data(id,content,copyfrom,relation,allow_comment) values ('52','文章内容内容内容内容','来源','1,2,3','1');
 insert  into cms_article_data(id,content,copyfrom,relation,allow_comment) values ('53','文章内容内容内容内容','来源','1,2,3','1');
 insert  into cms_article_data(id,content,copyfrom,relation,allow_comment) values ('6','文章内容内容内容内容','来源','1,2,3','1');
 insert  into cms_article_data(id,content,copyfrom,relation,allow_comment) values ('7','文章内容内容内容内容','来源','1,2,3','1');
 insert  into cms_article_data(id,content,copyfrom,relation,allow_comment) values ('8','文章内容内容内容内容','来源','1,2,3','1');
 insert  into cms_article_data(id,content,copyfrom,relation,allow_comment) values ('9','文章内容内容内容内容','来源','1,2,3','1');

 commit;
/*Table structure for table `cms_category` */

CREATE TABLE cms_category
(
	id varchar2(64) NOT NULL,
	parent_id varchar2(64) NOT NULL,
	parent_ids varchar2(2000) NOT NULL,
	site_id varchar2(64) DEFAULT '1',
	office_id varchar2(64),
	module varchar2(20),
	name varchar2(100) NOT NULL,
	image varchar2(255),
	href varchar2(255),
	target varchar2(20),
	description varchar2(255),
	keywords varchar2(255),
	sort number(10,0) DEFAULT 30,
	in_menu char(1) DEFAULT '1',
	in_list char(1) DEFAULT '1',
	show_modes char(1) DEFAULT '0',
	allow_comment char(1),
	is_audit char(1),
	custom_list_view varchar2(255),
	custom_content_view varchar2(255),
	view_config clob,
	create_by varchar2(64),
	create_date timestamp,
	update_by varchar2(64),
	update_date timestamp,
	remarks varchar2(255),
	del_flag char(1) DEFAULT '0' NOT NULL,
	PRIMARY KEY (id)
);

COMMENT ON TABLE cms_category IS '栏目表';
COMMENT ON COLUMN cms_category.id IS '编号';
COMMENT ON COLUMN cms_category.parent_id IS '父级编号';
COMMENT ON COLUMN cms_category.parent_ids IS '所有父级编号';
COMMENT ON COLUMN cms_category.site_id IS '站点编号';
COMMENT ON COLUMN cms_category.office_id IS '归属机构';
COMMENT ON COLUMN cms_category.module IS '栏目模块';
COMMENT ON COLUMN cms_category.name IS '栏目名称';
COMMENT ON COLUMN cms_category.image IS '栏目图片';
COMMENT ON COLUMN cms_category.href IS '链接';
COMMENT ON COLUMN cms_category.target IS '目标';
COMMENT ON COLUMN cms_category.description IS '描述';
COMMENT ON COLUMN cms_category.keywords IS '关键字';
COMMENT ON COLUMN cms_category.sort IS '排序（升序）';
COMMENT ON COLUMN cms_category.in_menu IS '是否在导航中显示';
COMMENT ON COLUMN cms_category.in_list IS '是否在分类页中显示列表';
COMMENT ON COLUMN cms_category.show_modes IS '展现方式';
COMMENT ON COLUMN cms_category.allow_comment IS '是否允许评论';
COMMENT ON COLUMN cms_category.is_audit IS '是否需要审核';
COMMENT ON COLUMN cms_category.custom_list_view IS '自定义列表视图';
COMMENT ON COLUMN cms_category.custom_content_view IS '自定义内容视图';
COMMENT ON COLUMN cms_category.view_config IS '视图配置';
COMMENT ON COLUMN cms_category.create_by IS '创建者';
COMMENT ON COLUMN cms_category.create_date IS '创建时间';
COMMENT ON COLUMN cms_category.update_by IS '更新者';
COMMENT ON COLUMN cms_category.update_date IS '更新时间';
COMMENT ON COLUMN cms_category.remarks IS '备注信息';
COMMENT ON COLUMN cms_category.del_flag IS '删除标记';

/*Data for the table `cms_category` */

insert  into cms_category(id,parent_id,parent_ids,site_id,office_id,module,name,image,href,target,description,keywords,sort,in_menu,in_list,show_modes,allow_comment,is_audit,custom_list_view,custom_content_view,view_config,create_by,create_date,update_by,update_date,remarks,del_flag) values ('1','0','0,','0','1',NULL,'顶级栏目',NULL,NULL,NULL,NULL,NULL,0,'1','1','0','0','1',NULL,NULL,NULL,'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0');
 insert  into cms_category(id,parent_id,parent_ids,site_id,office_id,module,name,image,href,target,description,keywords,sort,in_menu,in_list,show_modes,allow_comment,is_audit,custom_list_view,custom_content_view,view_config,create_by,create_date,update_by,update_date,remarks,del_flag) values ('10','1','0,1,','1','4','article','软件介绍',NULL,NULL,NULL,NULL,NULL,20,'1','1','0','1','0',NULL,NULL,NULL,'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0');
 insert  into cms_category(id,parent_id,parent_ids,site_id,office_id,module,name,image,href,target,description,keywords,sort,in_menu,in_list,show_modes,allow_comment,is_audit,custom_list_view,custom_content_view,view_config,create_by,create_date,update_by,update_date,remarks,del_flag) values ('11','10','0,1,10,','1','4','article','网络工具',NULL,NULL,NULL,NULL,NULL,30,'1','1','0','1','0',NULL,NULL,NULL,'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0');
 insert  into cms_category(id,parent_id,parent_ids,site_id,office_id,module,name,image,href,target,description,keywords,sort,in_menu,in_list,show_modes,allow_comment,is_audit,custom_list_view,custom_content_view,view_config,create_by,create_date,update_by,update_date,remarks,del_flag) values ('12','10','0,1,10,','1','4','article','浏览工具',NULL,NULL,NULL,NULL,NULL,40,'1','1','0','1','0',NULL,NULL,NULL,'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0');
 insert  into cms_category(id,parent_id,parent_ids,site_id,office_id,module,name,image,href,target,description,keywords,sort,in_menu,in_list,show_modes,allow_comment,is_audit,custom_list_view,custom_content_view,view_config,create_by,create_date,update_by,update_date,remarks,del_flag) values ('13','10','0,1,10,','1','4','article','浏览辅助',NULL,NULL,NULL,NULL,NULL,50,'1','1','0','1','0',NULL,NULL,NULL,'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0');
 insert  into cms_category(id,parent_id,parent_ids,site_id,office_id,module,name,image,href,target,description,keywords,sort,in_menu,in_list,show_modes,allow_comment,is_audit,custom_list_view,custom_content_view,view_config,create_by,create_date,update_by,update_date,remarks,del_flag) values ('14','10','0,1,10,','1','4','article','网络优化',NULL,NULL,NULL,NULL,NULL,50,'1','1','0','1','0',NULL,NULL,NULL,'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0');
 insert  into cms_category(id,parent_id,parent_ids,site_id,office_id,module,name,image,href,target,description,keywords,sort,in_menu,in_list,show_modes,allow_comment,is_audit,custom_list_view,custom_content_view,view_config,create_by,create_date,update_by,update_date,remarks,del_flag) values ('15','10','0,1,10,','1','4','article','邮件处理',NULL,NULL,NULL,NULL,NULL,50,'1','1','0','1','0',NULL,NULL,NULL,'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0');
 insert  into cms_category(id,parent_id,parent_ids,site_id,office_id,module,name,image,href,target,description,keywords,sort,in_menu,in_list,show_modes,allow_comment,is_audit,custom_list_view,custom_content_view,view_config,create_by,create_date,update_by,update_date,remarks,del_flag) values ('16','10','0,1,10,','1','4','article','下载工具',NULL,NULL,NULL,NULL,NULL,50,'1','1','0','1','0',NULL,NULL,NULL,'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0');
 insert  into cms_category(id,parent_id,parent_ids,site_id,office_id,module,name,image,href,target,description,keywords,sort,in_menu,in_list,show_modes,allow_comment,is_audit,custom_list_view,custom_content_view,view_config,create_by,create_date,update_by,update_date,remarks,del_flag) values ('17','10','0,1,10,','1','4','article','搜索工具',NULL,NULL,NULL,NULL,NULL,50,'1','1','2','1','0',NULL,NULL,NULL,'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0');
 insert  into cms_category(id,parent_id,parent_ids,site_id,office_id,module,name,image,href,target,description,keywords,sort,in_menu,in_list,show_modes,allow_comment,is_audit,custom_list_view,custom_content_view,view_config,create_by,create_date,update_by,update_date,remarks,del_flag) values ('18','1','0,1,','1','5','link','友情链接',NULL,NULL,NULL,NULL,NULL,90,'1','1','0','1','0',NULL,NULL,NULL,'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0');
 insert  into cms_category(id,parent_id,parent_ids,site_id,office_id,module,name,image,href,target,description,keywords,sort,in_menu,in_list,show_modes,allow_comment,is_audit,custom_list_view,custom_content_view,view_config,create_by,create_date,update_by,update_date,remarks,del_flag) values ('19','18','0,1,18,','1','5','link','常用网站',NULL,NULL,NULL,NULL,NULL,50,'1','1','0','1','0',NULL,NULL,NULL,'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0');
 insert  into cms_category(id,parent_id,parent_ids,site_id,office_id,module,name,image,href,target,description,keywords,sort,in_menu,in_list,show_modes,allow_comment,is_audit,custom_list_view,custom_content_view,view_config,create_by,create_date,update_by,update_date,remarks,del_flag) values ('2','1','0,1,','1','3','article','组织机构',NULL,NULL,NULL,NULL,NULL,10,'1','1','0','0','1',NULL,NULL,NULL,'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0');
 insert  into cms_category(id,parent_id,parent_ids,site_id,office_id,module,name,image,href,target,description,keywords,sort,in_menu,in_list,show_modes,allow_comment,is_audit,custom_list_view,custom_content_view,view_config,create_by,create_date,update_by,update_date,remarks,del_flag) values ('20','18','0,1,18,','1','5','link','门户网站',NULL,NULL,NULL,NULL,NULL,50,'1','1','0','1','0',NULL,NULL,NULL,'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0');
 insert  into cms_category(id,parent_id,parent_ids,site_id,office_id,module,name,image,href,target,description,keywords,sort,in_menu,in_list,show_modes,allow_comment,is_audit,custom_list_view,custom_content_view,view_config,create_by,create_date,update_by,update_date,remarks,del_flag) values ('21','18','0,1,18,','1','5','link','购物网站',NULL,NULL,NULL,NULL,NULL,50,'1','1','0','1','0',NULL,NULL,NULL,'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0');
 insert  into cms_category(id,parent_id,parent_ids,site_id,office_id,module,name,image,href,target,description,keywords,sort,in_menu,in_list,show_modes,allow_comment,is_audit,custom_list_view,custom_content_view,view_config,create_by,create_date,update_by,update_date,remarks,del_flag) values ('22','18','0,1,18,','1','5','link','交友社区',NULL,NULL,NULL,NULL,NULL,50,'1','1','0','1','0',NULL,NULL,NULL,'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0');
 insert  into cms_category(id,parent_id,parent_ids,site_id,office_id,module,name,image,href,target,description,keywords,sort,in_menu,in_list,show_modes,allow_comment,is_audit,custom_list_view,custom_content_view,view_config,create_by,create_date,update_by,update_date,remarks,del_flag) values ('23','18','0,1,18,','1','5','link','音乐视频',NULL,NULL,NULL,NULL,NULL,50,'1','1','0','1','0',NULL,NULL,NULL,'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0');
 insert  into cms_category(id,parent_id,parent_ids,site_id,office_id,module,name,image,href,target,description,keywords,sort,in_menu,in_list,show_modes,allow_comment,is_audit,custom_list_view,custom_content_view,view_config,create_by,create_date,update_by,update_date,remarks,del_flag) values ('24','1','0,1,','1','6',NULL,'百度一下',NULL,'http://www.baidu.com','_blank',NULL,NULL,90,'1','1','0','1','0',NULL,NULL,NULL,'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0');
 insert  into cms_category(id,parent_id,parent_ids,site_id,office_id,module,name,image,href,target,description,keywords,sort,in_menu,in_list,show_modes,allow_comment,is_audit,custom_list_view,custom_content_view,view_config,create_by,create_date,update_by,update_date,remarks,del_flag) values ('25','1','0,1,','1','6',NULL,'全文检索',NULL,'/search',NULL,NULL,NULL,90,'0','1','0','1','0',NULL,NULL,NULL,'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0');
 insert  into cms_category(id,parent_id,parent_ids,site_id,office_id,module,name,image,href,target,description,keywords,sort,in_menu,in_list,show_modes,allow_comment,is_audit,custom_list_view,custom_content_view,view_config,create_by,create_date,update_by,update_date,remarks,del_flag) values ('26','1','0,1,','2','6','article','测试栏目',NULL,NULL,NULL,NULL,NULL,90,'1','1','0','1','0',NULL,NULL,NULL,'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0');
 insert  into cms_category(id,parent_id,parent_ids,site_id,office_id,module,name,image,href,target,description,keywords,sort,in_menu,in_list,show_modes,allow_comment,is_audit,custom_list_view,custom_content_view,view_config,create_by,create_date,update_by,update_date,remarks,del_flag) values ('27','1','0,1,','1','6',NULL,'公共留言',NULL,'/guestbook',NULL,NULL,NULL,90,'1','1','0','1','0',NULL,NULL,NULL,'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0');
 insert  into cms_category(id,parent_id,parent_ids,site_id,office_id,module,name,image,href,target,description,keywords,sort,in_menu,in_list,show_modes,allow_comment,is_audit,custom_list_view,custom_content_view,view_config,create_by,create_date,update_by,update_date,remarks,del_flag) values ('3','2','0,1,2,','1','3','article','网站简介',NULL,NULL,NULL,NULL,NULL,30,'1','1','0','0','1',NULL,NULL,NULL,'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0');
 insert  into cms_category(id,parent_id,parent_ids,site_id,office_id,module,name,image,href,target,description,keywords,sort,in_menu,in_list,show_modes,allow_comment,is_audit,custom_list_view,custom_content_view,view_config,create_by,create_date,update_by,update_date,remarks,del_flag) values ('4','2','0,1,2,','1','3','article','内部机构',NULL,NULL,NULL,NULL,NULL,40,'1','1','0','0','1',NULL,NULL,NULL,'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0');
 insert  into cms_category(id,parent_id,parent_ids,site_id,office_id,module,name,image,href,target,description,keywords,sort,in_menu,in_list,show_modes,allow_comment,is_audit,custom_list_view,custom_content_view,view_config,create_by,create_date,update_by,update_date,remarks,del_flag) values ('5','2','0,1,2,','1','3','article','地方机构',NULL,NULL,NULL,NULL,NULL,50,'1','1','0','0','1',NULL,NULL,NULL,'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0');
 insert  into cms_category(id,parent_id,parent_ids,site_id,office_id,module,name,image,href,target,description,keywords,sort,in_menu,in_list,show_modes,allow_comment,is_audit,custom_list_view,custom_content_view,view_config,create_by,create_date,update_by,update_date,remarks,del_flag) values ('6','1','0,1,','1','3','article','质量检验',NULL,NULL,NULL,NULL,NULL,20,'1','1','1','1','0',NULL,NULL,NULL,'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0');
 insert  into cms_category(id,parent_id,parent_ids,site_id,office_id,module,name,image,href,target,description,keywords,sort,in_menu,in_list,show_modes,allow_comment,is_audit,custom_list_view,custom_content_view,view_config,create_by,create_date,update_by,update_date,remarks,del_flag) values ('7','6','0,1,6,','1','3','article','产品质量',NULL,NULL,NULL,NULL,NULL,30,'1','1','0','1','0',NULL,NULL,NULL,'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0');
 insert  into cms_category(id,parent_id,parent_ids,site_id,office_id,module,name,image,href,target,description,keywords,sort,in_menu,in_list,show_modes,allow_comment,is_audit,custom_list_view,custom_content_view,view_config,create_by,create_date,update_by,update_date,remarks,del_flag) values ('8','6','0,1,6,','1','3','article','技术质量',NULL,NULL,NULL,NULL,NULL,40,'1','1','0','1','0',NULL,NULL,NULL,'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0');
 insert  into cms_category(id,parent_id,parent_ids,site_id,office_id,module,name,image,href,target,description,keywords,sort,in_menu,in_list,show_modes,allow_comment,is_audit,custom_list_view,custom_content_view,view_config,create_by,create_date,update_by,update_date,remarks,del_flag) values ('9','6','0,1,6,','1','3','article','工程质量',NULL,NULL,NULL,NULL,NULL,50,'1','1','0','1','0',NULL,NULL,NULL,'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0');
commit;
/*Table structure for table `cms_comment` */

CREATE TABLE cms_comment
(
	id varchar2(64) NOT NULL,
	category_id varchar2(64) NOT NULL,
	content_id varchar2(64) NOT NULL,
	title varchar2(255),
	content varchar2(255),
	name varchar2(100),
	ip varchar2(100),
	create_date timestamp NOT NULL,
	audit_user_id varchar2(64),
	audit_date timestamp,
	del_flag char(1) DEFAULT '0' NOT NULL,
	PRIMARY KEY (id)
);

COMMENT ON TABLE cms_comment IS '评论表';
COMMENT ON COLUMN cms_comment.id IS '编号';
COMMENT ON COLUMN cms_comment.category_id IS '栏目编号';
COMMENT ON COLUMN cms_comment.content_id IS '栏目内容的编号';
COMMENT ON COLUMN cms_comment.title IS '栏目内容的标题';
COMMENT ON COLUMN cms_comment.content IS '评论内容';
COMMENT ON COLUMN cms_comment.name IS '评论姓名';
COMMENT ON COLUMN cms_comment.ip IS '评论IP';
COMMENT ON COLUMN cms_comment.create_date IS '评论时间';
COMMENT ON COLUMN cms_comment.audit_user_id IS '审核人';
COMMENT ON COLUMN cms_comment.audit_date IS '审核时间';
COMMENT ON COLUMN cms_comment.del_flag IS '删除标记';

/*Data for the table `cms_comment` */

/*Table structure for table `cms_guestbook` */

CREATE TABLE cms_guestbook
(
	id varchar2(64) NOT NULL,
	type char(1) NOT NULL,
	content varchar2(255) NOT NULL,
	name varchar2(100) NOT NULL,
	email varchar2(100) NOT NULL,
	phone varchar2(100) NOT NULL,
	workunit varchar2(100) NOT NULL,
	ip varchar2(100) NOT NULL,
	create_date timestamp NOT NULL,
	re_user_id varchar2(64),
	re_date timestamp,
	re_content varchar2(100),
	del_flag char(1) DEFAULT '0' NOT NULL,
	PRIMARY KEY (id)
);

COMMENT ON TABLE cms_guestbook IS '留言板';
COMMENT ON COLUMN cms_guestbook.id IS '编号';
COMMENT ON COLUMN cms_guestbook.type IS '留言分类';
COMMENT ON COLUMN cms_guestbook.content IS '留言内容';
COMMENT ON COLUMN cms_guestbook.name IS '姓名';
COMMENT ON COLUMN cms_guestbook.email IS '邮箱';
COMMENT ON COLUMN cms_guestbook.phone IS '电话';
COMMENT ON COLUMN cms_guestbook.workunit IS '单位';
COMMENT ON COLUMN cms_guestbook.ip IS 'IP';
COMMENT ON COLUMN cms_guestbook.create_date IS '留言时间';
COMMENT ON COLUMN cms_guestbook.re_user_id IS '回复人';
COMMENT ON COLUMN cms_guestbook.re_date IS '回复时间';
COMMENT ON COLUMN cms_guestbook.re_content IS '回复内容';
COMMENT ON COLUMN cms_guestbook.del_flag IS '删除标记';


/*Data for the table `cms_guestbook` */

/*Table structure for table `cms_link` */

CREATE TABLE cms_link
(
	id varchar2(64) NOT NULL,
	category_id varchar2(64) NOT NULL,
	title varchar2(255) NOT NULL,
	color varchar2(50),
	image varchar2(255),
	href varchar2(255),
	weight number(10,0) DEFAULT 0,
	weight_date timestamp,
	create_by varchar2(64),
	create_date timestamp,
	update_by varchar2(64),
	update_date timestamp,
	remarks varchar2(255),
	del_flag char(1) DEFAULT '0' NOT NULL,
	PRIMARY KEY (id)
);


COMMENT ON TABLE cms_link IS '友情链接';
COMMENT ON COLUMN cms_link.id IS '编号';
COMMENT ON COLUMN cms_link.category_id IS '栏目编号';
COMMENT ON COLUMN cms_link.title IS '链接名称';
COMMENT ON COLUMN cms_link.color IS '标题颜色';
COMMENT ON COLUMN cms_link.image IS '链接图片';
COMMENT ON COLUMN cms_link.href IS '链接地址';
COMMENT ON COLUMN cms_link.weight IS '权重，越大越靠前';
COMMENT ON COLUMN cms_link.weight_date IS '权重期限';
COMMENT ON COLUMN cms_link.create_by IS '创建者';
COMMENT ON COLUMN cms_link.create_date IS '创建时间';
COMMENT ON COLUMN cms_link.update_by IS '更新者';
COMMENT ON COLUMN cms_link.update_date IS '更新时间';
COMMENT ON COLUMN cms_link.remarks IS '备注信息';
COMMENT ON COLUMN cms_link.del_flag IS '删除标记';

/*Data for the table `cms_link` */

insert  into cms_link(id,category_id,title,color,image,href,weight,weight_date,create_by,create_date,update_by,update_date,remarks,del_flag) values ('1','19','kcfw',NULL,NULL,'http://krazy.github.com/kcfw',0,NULL,'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0');
 insert  into cms_link(id,category_id,title,color,image,href,weight,weight_date,create_by,create_date,update_by,update_date,remarks,del_flag) values ('10','22','58同城',NULL,NULL,'http://www.58.com/',0,NULL,'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0');
 insert  into cms_link(id,category_id,title,color,image,href,weight,weight_date,create_by,create_date,update_by,update_date,remarks,del_flag) values ('11','23','视频大全',NULL,NULL,'http://v.360.cn/',0,NULL,'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0');
 insert  into cms_link(id,category_id,title,color,image,href,weight,weight_date,create_by,create_date,update_by,update_date,remarks,del_flag) values ('12','23','凤凰网',NULL,NULL,'http://www.ifeng.com/',0,NULL,'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0');
 insert  into cms_link(id,category_id,title,color,image,href,weight,weight_date,create_by,create_date,update_by,update_date,remarks,del_flag) values ('2','19','krazy',NULL,NULL,'http://krazy.iteye.com/',0,NULL,'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0');
 insert  into cms_link(id,category_id,title,color,image,href,weight,weight_date,create_by,create_date,update_by,update_date,remarks,del_flag) values ('3','19','百度一下',NULL,NULL,'http://www.baidu.com',0,NULL,'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0');
 insert  into cms_link(id,category_id,title,color,image,href,weight,weight_date,create_by,create_date,update_by,update_date,remarks,del_flag) values ('4','19','谷歌搜索',NULL,NULL,'http://www.google.com',0,NULL,'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0');
 insert  into cms_link(id,category_id,title,color,image,href,weight,weight_date,create_by,create_date,update_by,update_date,remarks,del_flag) values ('5','20','新浪网',NULL,NULL,'http://www.sina.com.cn',0,NULL,'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0');
 insert  into cms_link(id,category_id,title,color,image,href,weight,weight_date,create_by,create_date,update_by,update_date,remarks,del_flag) values ('6','20','腾讯网',NULL,NULL,'http://www.qq.com/',0,NULL,'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0');
 insert  into cms_link(id,category_id,title,color,image,href,weight,weight_date,create_by,create_date,update_by,update_date,remarks,del_flag) values ('7','21','淘宝网',NULL,NULL,'http://www.taobao.com/',0,NULL,'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0');
 insert  into cms_link(id,category_id,title,color,image,href,weight,weight_date,create_by,create_date,update_by,update_date,remarks,del_flag) values ('8','21','新华网',NULL,NULL,'http://www.xinhuanet.com/',0,NULL,'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0');
 insert  into cms_link(id,category_id,title,color,image,href,weight,weight_date,create_by,create_date,update_by,update_date,remarks,del_flag) values ('9','22','赶集网',NULL,NULL,'http://www.ganji.com/',0,NULL,'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0');
commit;
/*Table structure for table `cms_site` */

CREATE TABLE cms_site
(
	id varchar2(64) NOT NULL,
	name varchar2(100) NOT NULL,
	title varchar2(100) NOT NULL,
	logo varchar2(255),
	domain varchar2(255),
	description varchar2(255),
	keywords varchar2(255),
	theme varchar2(255) DEFAULT 'default',
	copyright clob,
	custom_index_view varchar2(255),
	create_by varchar2(64),
	create_date timestamp,
	update_by varchar2(64),
	update_date timestamp,
	remarks varchar2(255),
	del_flag char(1) DEFAULT '0' NOT NULL,
	PRIMARY KEY (id)
);

COMMENT ON TABLE cms_site IS '站点表';
COMMENT ON COLUMN cms_site.id IS '编号';
COMMENT ON COLUMN cms_site.name IS '站点名称';
COMMENT ON COLUMN cms_site.title IS '站点标题';
COMMENT ON COLUMN cms_site.logo IS '站点Logo';
COMMENT ON COLUMN cms_site.domain IS '站点域名';
COMMENT ON COLUMN cms_site.description IS '描述';
COMMENT ON COLUMN cms_site.keywords IS '关键字';
COMMENT ON COLUMN cms_site.theme IS '主题';
COMMENT ON COLUMN cms_site.copyright IS '版权信息';
COMMENT ON COLUMN cms_site.custom_index_view IS '自定义站点首页视图';
COMMENT ON COLUMN cms_site.create_by IS '创建者';
COMMENT ON COLUMN cms_site.create_date IS '创建时间';
COMMENT ON COLUMN cms_site.update_by IS '更新者';
COMMENT ON COLUMN cms_site.update_date IS '更新时间';
COMMENT ON COLUMN cms_site.remarks IS '备注信息';
COMMENT ON COLUMN cms_site.del_flag IS '删除标记';

/*Data for the table `cms_site` */

insert  into cms_site(id,name,title,logo,domain,description,keywords,theme,copyright,custom_index_view,create_by,create_date,update_by,update_date,remarks,del_flag) values ('1','默认站点','kcfw Web',NULL,NULL,'kcfw','kcfw','basic','Copyright &copy; 2012-2013 <a href=''http://krazy.iteye.com'' target=''_blank''>krazy</a> - Powered By <a href=''https://github.com/krazy/kcfw'' target=''_blank''>kcfw</a> V1.0',NULL,'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0');
insert  into cms_site(id,name,title,logo,domain,description,keywords,theme,copyright,custom_index_view,create_by,create_date,update_by,update_date,remarks,del_flag) values ('2','子站点测试','kcfw Subsite',NULL,NULL,'kcfw subsite','kcfw subsite','basic','Copyright &copy; 2012-2013 <a href=''http://krazy.iteye.com'' target=''_blank''>krazy</a> - Powered By <a href=''https://github.com/krazy/kcfw'' target=''_blank''>kcfw</a> V1.0',NULL,'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0');

commit;

/*Table structure for table `gen_scheme` */

/* Create Tables */

CREATE TABLE gen_scheme
(
	id varchar2(64) NOT NULL,
	name nvarchar2(200),
	category varchar2(2000),
	package_name varchar2(500),
	module_name varchar2(30),
	sub_module_name varchar2(30),
	function_name nvarchar2(500),
	function_name_simple nvarchar2(100),
	function_author nvarchar2(100),
	gen_table_id varchar2(200),
	create_by varchar2(64),
	create_date timestamp,
	update_by varchar2(64),
	update_date timestamp,
	remarks nvarchar2(255),
	del_flag char(1) DEFAULT '0' NOT NULL,
	PRIMARY KEY (id)
);

COMMENT ON TABLE gen_scheme IS '生成方案';
COMMENT ON COLUMN gen_scheme.id IS '编号';
COMMENT ON COLUMN gen_scheme.name IS '名称';
COMMENT ON COLUMN gen_scheme.category IS '分类';
COMMENT ON COLUMN gen_scheme.package_name IS '生成包路径';
COMMENT ON COLUMN gen_scheme.module_name IS '生成模块名';
COMMENT ON COLUMN gen_scheme.sub_module_name IS '生成子模块名';
COMMENT ON COLUMN gen_scheme.function_name IS '生成功能名';
COMMENT ON COLUMN gen_scheme.function_name_simple IS '生成功能名（简写）';
COMMENT ON COLUMN gen_scheme.function_author IS '生成功能作者';
COMMENT ON COLUMN gen_scheme.gen_table_id IS '生成表编号';
COMMENT ON COLUMN gen_scheme.create_by IS '创建者';
COMMENT ON COLUMN gen_scheme.create_date IS '创建时间';
COMMENT ON COLUMN gen_scheme.update_by IS '更新者';
COMMENT ON COLUMN gen_scheme.update_date IS '更新时间';
COMMENT ON COLUMN gen_scheme.remarks IS '备注信息';
COMMENT ON COLUMN gen_scheme.del_flag IS '删除标记（0：正常；1：删除）';


/*Data for the table `gen_scheme` */
-- prompt Loading GEN_SCHEME...
insert into GEN_SCHEME (ID, NAME, CATEGORY, PACKAGE_NAME, MODULE_NAME, SUB_MODULE_NAME, FUNCTION_NAME, FUNCTION_NAME_SIMPLE, FUNCTION_AUTHOR, GEN_TABLE_ID, CREATE_BY, CREATE_DATE, UPDATE_BY, UPDATE_DATE, REMARKS, DEL_FLAG)
values ('9c9de9db6da743bb899036c6546061ac', '单表', 'curd', 'com.krazy.jeesite.modules', 'test', null, '单表生成', '单表', 'krazy', 'aef6f1fc948f4c9ab1c1b780bc471cc2', '1', to_timestamp('08-12-2013 11:11:05.943000', 'dd-mm-yyyy hh24:mi:ss.ff'), '1', to_timestamp('08-12-2013 11:28:13.953000', 'dd-mm-yyyy hh24:mi:ss.ff'), null, '0');
insert into GEN_SCHEME (ID, NAME, CATEGORY, PACKAGE_NAME, MODULE_NAME, SUB_MODULE_NAME, FUNCTION_NAME, FUNCTION_NAME_SIMPLE, FUNCTION_AUTHOR, GEN_TABLE_ID, CREATE_BY, CREATE_DATE, UPDATE_BY, UPDATE_DATE, REMARKS, DEL_FLAG)
values ('e6d905fd236b46d1af581dd32bdfb3b0', '主子表', 'curd_many', 'com.krazy.jeesite.modules', 'test', null, '主子表生成', '主子表', 'krazy', '43d6d5acffa14c258340ce6765e46c6f', '1', to_timestamp('08-12-2013 11:13:34.428000', 'dd-mm-yyyy hh24:mi:ss.ff'), '1', to_timestamp('08-12-2013 11:42:16.729000', 'dd-mm-yyyy hh24:mi:ss.ff'), null, '0');
insert into GEN_SCHEME (ID, NAME, CATEGORY, PACKAGE_NAME, MODULE_NAME, SUB_MODULE_NAME, FUNCTION_NAME, FUNCTION_NAME_SIMPLE, FUNCTION_AUTHOR, GEN_TABLE_ID, CREATE_BY, CREATE_DATE, UPDATE_BY, UPDATE_DATE, REMARKS, DEL_FLAG)
values ('35a13dc260284a728a270db3f382664b', '树结构', 'treeTable', 'com.krazy.jeesite.modules', 'test', null, '树结构生成', '树结构', 'krazy', 'f6e4dafaa72f4c509636484715f33a96', '1', to_timestamp('08-12-2013 11:17:06.818000', 'dd-mm-yyyy hh24:mi:ss.ff'), '1', to_timestamp('08-12-2013 13:50:01.781000', 'dd-mm-yyyy hh24:mi:ss.ff'), null, '0');
commit;
/*Table structure for table `gen_table` */

CREATE TABLE gen_table
(
	id varchar2(64) NOT NULL,
	name nvarchar2(200),
	comments nvarchar2(500),
	class_name varchar2(100),
	parent_table varchar2(200),
	parent_table_fk varchar2(100),
	create_by varchar2(64),
	create_date timestamp,
	update_by varchar2(64),
	update_date timestamp,
	remarks nvarchar2(255),
	del_flag char(1) DEFAULT '0' NOT NULL,
	PRIMARY KEY (id)
);

COMMENT ON TABLE gen_table IS '业务表';
COMMENT ON COLUMN gen_table.id IS '编号';
COMMENT ON COLUMN gen_table.name IS '名称';
COMMENT ON COLUMN gen_table.comments IS '描述';
COMMENT ON COLUMN gen_table.class_name IS '实体类名称';
COMMENT ON COLUMN gen_table.parent_table IS '关联父表';
COMMENT ON COLUMN gen_table.parent_table_fk IS '关联父表外键';
COMMENT ON COLUMN gen_table.create_by IS '创建者';
COMMENT ON COLUMN gen_table.create_date IS '创建时间';
COMMENT ON COLUMN gen_table.update_by IS '更新者';
COMMENT ON COLUMN gen_table.update_date IS '更新时间';
COMMENT ON COLUMN gen_table.remarks IS '备注信息';
COMMENT ON COLUMN gen_table.del_flag IS '删除标记（0：正常；1：删除）';


/*Data for the table `gen_table` */

insert into GEN_TABLE (ID, NAME, COMMENTS, CLASS_NAME, PARENT_TABLE, PARENT_TABLE_FK, CREATE_BY, CREATE_DATE, UPDATE_BY, UPDATE_DATE, REMARKS, DEL_FLAG)
values ('aef6f1fc948f4c9ab1c1b780bc471cc2', 'test_data', '业务数据表', 'TestData', null, null, '1', to_timestamp('08-12-2013 11:10:28.984000', 'dd-mm-yyyy hh24:mi:ss.ff'), '1', to_timestamp('08-12-2013 11:28:00.511000', 'dd-mm-yyyy hh24:mi:ss.ff'), null, '0');
insert into GEN_TABLE (ID, NAME, COMMENTS, CLASS_NAME, PARENT_TABLE, PARENT_TABLE_FK, CREATE_BY, CREATE_DATE, UPDATE_BY, UPDATE_DATE, REMARKS, DEL_FLAG)
values ('43d6d5acffa14c258340ce6765e46c6f', 'test_data_main', '业务数据表', 'TestDataMain', null, null, '1', to_timestamp('08-12-2013 11:11:59.745000', 'dd-mm-yyyy hh24:mi:ss.ff'), '1', to_timestamp('08-12-2013 11:26:16.360000', 'dd-mm-yyyy hh24:mi:ss.ff'), null, '0');
insert into GEN_TABLE (ID, NAME, COMMENTS, CLASS_NAME, PARENT_TABLE, PARENT_TABLE_FK, CREATE_BY, CREATE_DATE, UPDATE_BY, UPDATE_DATE, REMARKS, DEL_FLAG)
values ('6e05c389f3c6415ea34e55e9dfb28934', 'test_data_child', '业务数据子表', 'TestDataChild', 'test_data_main', 'test_data_main_id', '1', to_timestamp('08-12-2013 11:12:57.960000', 'dd-mm-yyyy hh24:mi:ss.ff'), '1', to_timestamp('08-12-2013 11:30:22.324000', 'dd-mm-yyyy hh24:mi:ss.ff'), null, '0');
insert into GEN_TABLE (ID, NAME, COMMENTS, CLASS_NAME, PARENT_TABLE, PARENT_TABLE_FK, CREATE_BY, CREATE_DATE, UPDATE_BY, UPDATE_DATE, REMARKS, DEL_FLAG)
values ('f6e4dafaa72f4c509636484715f33a96', 'test_tree', '树结构表', 'TestTree', null, null, '1', to_timestamp('08-12-2013 11:16:19.093000', 'dd-mm-yyyy hh24:mi:ss.ff'), '1', to_timestamp('08-12-2013 13:49:47.755000', 'dd-mm-yyyy hh24:mi:ss.ff'), null, '0');
commit;
/*Table structure for table `gen_table_column` */


CREATE TABLE gen_table_column
(
	id varchar2(64) NOT NULL,
	gen_table_id varchar2(64),
	name nvarchar2(200),
	comments nvarchar2(500),
	jdbc_type varchar2(100),
	java_type varchar2(500),
	java_field varchar2(200),
	is_pk char(1),
	is_null char(1),
	is_insert char(1),
	is_edit char(1),
	is_list char(1),
	is_query char(1),
	query_type varchar2(200),
	show_type varchar2(200),
	dict_type varchar2(200),
	settings nvarchar2(2000),
	sort number,
	create_by varchar2(64),
	create_date timestamp,
	update_by varchar2(64),
	update_date timestamp,
	remarks nvarchar2(255),
	del_flag char(1) DEFAULT '0' NOT NULL,
	PRIMARY KEY (id)
);

COMMENT ON TABLE gen_table_column IS '业务表字段';
COMMENT ON COLUMN gen_table_column.id IS '编号';
COMMENT ON COLUMN gen_table_column.gen_table_id IS '归属表编号';
COMMENT ON COLUMN gen_table_column.name IS '名称';
COMMENT ON COLUMN gen_table_column.comments IS '描述';
COMMENT ON COLUMN gen_table_column.jdbc_type IS '列的数据类型的字节长度';
COMMENT ON COLUMN gen_table_column.java_type IS 'JAVA类型';
COMMENT ON COLUMN gen_table_column.java_field IS 'JAVA字段名';
COMMENT ON COLUMN gen_table_column.is_pk IS '是否主键';
COMMENT ON COLUMN gen_table_column.is_null IS '是否可为空';
COMMENT ON COLUMN gen_table_column.is_insert IS '是否为插入字段';
COMMENT ON COLUMN gen_table_column.is_edit IS '是否编辑字段';
COMMENT ON COLUMN gen_table_column.is_list IS '是否列表字段';
COMMENT ON COLUMN gen_table_column.is_query IS '是否查询字段';
COMMENT ON COLUMN gen_table_column.query_type IS '查询方式（等于、不等于、大于、小于、范围、左LIKE、右LIKE、左右LIKE）';
COMMENT ON COLUMN gen_table_column.show_type IS '字段生成方案（文本框、文本域、下拉框、复选框、单选框、字典选择、人员选择、部门选择、区域选择）';
COMMENT ON COLUMN gen_table_column.dict_type IS '字典类型';
COMMENT ON COLUMN gen_table_column.settings IS '其它设置（扩展字段JSON）';
COMMENT ON COLUMN gen_table_column.sort IS '排序（升序）';
COMMENT ON COLUMN gen_table_column.create_by IS '创建者';
COMMENT ON COLUMN gen_table_column.create_date IS '创建时间';
COMMENT ON COLUMN gen_table_column.update_by IS '更新者';
COMMENT ON COLUMN gen_table_column.update_date IS '更新时间';
COMMENT ON COLUMN gen_table_column.remarks IS '备注信息';
COMMENT ON COLUMN gen_table_column.del_flag IS '删除标记（0：正常；1：删除）';


/*Data for the table `gen_table_column` */

insert into GEN_TABLE_COLUMN (ID, GEN_TABLE_ID, NAME, COMMENTS, JDBC_TYPE, JAVA_TYPE, JAVA_FIELD, IS_PK, IS_NULL, IS_INSERT, IS_EDIT, IS_LIST, IS_QUERY, QUERY_TYPE, SHOW_TYPE, DICT_TYPE, SETTINGS, SORT, CREATE_BY, CREATE_DATE, UPDATE_BY, UPDATE_DATE, REMARKS, DEL_FLAG)
values ('5e5c69bd3eaa4dcc9743f361f3771c08', 'aef6f1fc948f4c9ab1c1b780bc471cc2', 'id', '编号', 'varchar2(64)', 'String', 'id', '1', '0', '1', '0', '0', '0', '=', 'input', null, null, 1, '1', to_timestamp('08-12-2013 11:10:29.017000', 'dd-mm-yyyy hh24:mi:ss.ff'), '1', to_timestamp('08-12-2013 11:28:00.513000', 'dd-mm-yyyy hh24:mi:ss.ff'), null, '0');
insert into GEN_TABLE_COLUMN (ID, GEN_TABLE_ID, NAME, COMMENTS, JDBC_TYPE, JAVA_TYPE, JAVA_FIELD, IS_PK, IS_NULL, IS_INSERT, IS_EDIT, IS_LIST, IS_QUERY, QUERY_TYPE, SHOW_TYPE, DICT_TYPE, SETTINGS, SORT, CREATE_BY, CREATE_DATE, UPDATE_BY, UPDATE_DATE, REMARKS, DEL_FLAG)
values ('1d5ca4d114be41e99f8dc42a682ba609', 'aef6f1fc948f4c9ab1c1b780bc471cc2', 'user_id', '归属用户', 'varchar2(64)', 'com.krazy.jeesite.modules.modules.sys.entity.User', 'user.id|name', '0', '1', '1', '1', '1', '1', '=', 'userselect', null, null, 2, '1', to_timestamp('08-12-2013 11:10:29.125000', 'dd-mm-yyyy hh24:mi:ss.ff'), '1', to_timestamp('08-12-2013 11:28:00.515000', 'dd-mm-yyyy hh24:mi:ss.ff'), null, '0');
insert into GEN_TABLE_COLUMN (ID, GEN_TABLE_ID, NAME, COMMENTS, JDBC_TYPE, JAVA_TYPE, JAVA_FIELD, IS_PK, IS_NULL, IS_INSERT, IS_EDIT, IS_LIST, IS_QUERY, QUERY_TYPE, SHOW_TYPE, DICT_TYPE, SETTINGS, SORT, CREATE_BY, CREATE_DATE, UPDATE_BY, UPDATE_DATE, REMARKS, DEL_FLAG)
values ('ad3bf0d4b44b4528a5211a66af88f322', 'aef6f1fc948f4c9ab1c1b780bc471cc2', 'office_id', '归属部门', 'varchar2(64)', 'com.krazy.jeesite.modules.modules.sys.entity.Office', 'office.id|name', '0', '1', '1', '1', '1', '1', '=', 'officeselect', null, null, 3, '1', to_timestamp('08-12-2013 11:10:29.128000', 'dd-mm-yyyy hh24:mi:ss.ff'), '1', to_timestamp('08-12-2013 11:28:00.517000', 'dd-mm-yyyy hh24:mi:ss.ff'), null, '0');
insert into GEN_TABLE_COLUMN (ID, GEN_TABLE_ID, NAME, COMMENTS, JDBC_TYPE, JAVA_TYPE, JAVA_FIELD, IS_PK, IS_NULL, IS_INSERT, IS_EDIT, IS_LIST, IS_QUERY, QUERY_TYPE, SHOW_TYPE, DICT_TYPE, SETTINGS, SORT, CREATE_BY, CREATE_DATE, UPDATE_BY, UPDATE_DATE, REMARKS, DEL_FLAG)
values ('71ea4bc10d274911b405f3165fc1bb1a', 'aef6f1fc948f4c9ab1c1b780bc471cc2', 'area_id', '归属区域', 'nvarchar2(64)', 'com.krazy.jeesite.modules.modules.sys.entity.Area', 'area.id|name', '0', '1', '1', '1', '1', '1', '=', 'areaselect', null, null, 4, '1', to_timestamp('08-12-2013 11:10:29.130000', 'dd-mm-yyyy hh24:mi:ss.ff'), '1', to_timestamp('08-12-2013 11:28:00.520000', 'dd-mm-yyyy hh24:mi:ss.ff'), null, '0');
insert into GEN_TABLE_COLUMN (ID, GEN_TABLE_ID, NAME, COMMENTS, JDBC_TYPE, JAVA_TYPE, JAVA_FIELD, IS_PK, IS_NULL, IS_INSERT, IS_EDIT, IS_LIST, IS_QUERY, QUERY_TYPE, SHOW_TYPE, DICT_TYPE, SETTINGS, SORT, CREATE_BY, CREATE_DATE, UPDATE_BY, UPDATE_DATE, REMARKS, DEL_FLAG)
values ('4a0a1fff86ca46519477d66b82e01991', 'aef6f1fc948f4c9ab1c1b780bc471cc2', 'name', '名称', 'nvarchar2(100)', 'String', 'name', '0', '1', '1', '1', '1', '1', 'like', 'input', null, null, 5, '1', to_timestamp('08-12-2013 11:10:29.131000', 'dd-mm-yyyy hh24:mi:ss.ff'), '1', to_timestamp('08-12-2013 11:28:00.522000', 'dd-mm-yyyy hh24:mi:ss.ff'), null, '0');
insert into GEN_TABLE_COLUMN (ID, GEN_TABLE_ID, NAME, COMMENTS, JDBC_TYPE, JAVA_TYPE, JAVA_FIELD, IS_PK, IS_NULL, IS_INSERT, IS_EDIT, IS_LIST, IS_QUERY, QUERY_TYPE, SHOW_TYPE, DICT_TYPE, SETTINGS, SORT, CREATE_BY, CREATE_DATE, UPDATE_BY, UPDATE_DATE, REMARKS, DEL_FLAG)
values ('0902a0cb3e8f434280c20e9d771d0658', 'aef6f1fc948f4c9ab1c1b780bc471cc2', 'sex', '性别', 'char(1)', 'String', 'sex', '0', '1', '1', '1', '1', '1', '=', 'radiobox', 'sex', null, 6, '1', to_timestamp('08-12-2013 11:10:29.133000', 'dd-mm-yyyy hh24:mi:ss.ff'), '1', to_timestamp('08-12-2013 11:28:00.524000', 'dd-mm-yyyy hh24:mi:ss.ff'), null, '0');
insert into GEN_TABLE_COLUMN (ID, GEN_TABLE_ID, NAME, COMMENTS, JDBC_TYPE, JAVA_TYPE, JAVA_FIELD, IS_PK, IS_NULL, IS_INSERT, IS_EDIT, IS_LIST, IS_QUERY, QUERY_TYPE, SHOW_TYPE, DICT_TYPE, SETTINGS, SORT, CREATE_BY, CREATE_DATE, UPDATE_BY, UPDATE_DATE, REMARKS, DEL_FLAG)
values ('1b8eb55f65284fa6b0a5879b6d8ad3ec', 'aef6f1fc948f4c9ab1c1b780bc471cc2', 'in_date', '加入日期', 'date(7)', 'java.util.Date', 'inDate', '0', '1', '1', '1', '0', '1', 'between', 'dateselect', null, null, 7, '1', to_timestamp('08-12-2013 11:10:29.134000', 'dd-mm-yyyy hh24:mi:ss.ff'), '1', to_timestamp('08-12-2013 11:28:00.526000', 'dd-mm-yyyy hh24:mi:ss.ff'), null, '0');
insert into GEN_TABLE_COLUMN (ID, GEN_TABLE_ID, NAME, COMMENTS, JDBC_TYPE, JAVA_TYPE, JAVA_FIELD, IS_PK, IS_NULL, IS_INSERT, IS_EDIT, IS_LIST, IS_QUERY, QUERY_TYPE, SHOW_TYPE, DICT_TYPE, SETTINGS, SORT, CREATE_BY, CREATE_DATE, UPDATE_BY, UPDATE_DATE, REMARKS, DEL_FLAG)
values ('398b4a03f06940bfb979ca574e1911e3', 'aef6f1fc948f4c9ab1c1b780bc471cc2', 'create_by', '创建者', 'varchar2(64)', 'com.krazy.jeesite.modules.modules.sys.entity.User', 'createBy.id', '0', '0', '1', '0', '0', '0', '=', 'input', null, null, 8, '1', to_timestamp('08-12-2013 11:10:29.136000', 'dd-mm-yyyy hh24:mi:ss.ff'), '1', to_timestamp('08-12-2013 11:28:00.700000', 'dd-mm-yyyy hh24:mi:ss.ff'), null, '0');
insert into GEN_TABLE_COLUMN (ID, GEN_TABLE_ID, NAME, COMMENTS, JDBC_TYPE, JAVA_TYPE, JAVA_FIELD, IS_PK, IS_NULL, IS_INSERT, IS_EDIT, IS_LIST, IS_QUERY, QUERY_TYPE, SHOW_TYPE, DICT_TYPE, SETTINGS, SORT, CREATE_BY, CREATE_DATE, UPDATE_BY, UPDATE_DATE, REMARKS, DEL_FLAG)
values ('103fc05c88ff40639875c2111881996a', 'aef6f1fc948f4c9ab1c1b780bc471cc2', 'create_date', '创建时间', 'timestamp(6)', 'java.util.Date', 'createDate', '0', '0', '1', '0', '0', '0', '=', 'dateselect', null, null, 9, '1', to_timestamp('08-12-2013 11:10:29.137000', 'dd-mm-yyyy hh24:mi:ss.ff'), '1', to_timestamp('08-12-2013 11:28:00.717000', 'dd-mm-yyyy hh24:mi:ss.ff'), null, '0');
insert into GEN_TABLE_COLUMN (ID, GEN_TABLE_ID, NAME, COMMENTS, JDBC_TYPE, JAVA_TYPE, JAVA_FIELD, IS_PK, IS_NULL, IS_INSERT, IS_EDIT, IS_LIST, IS_QUERY, QUERY_TYPE, SHOW_TYPE, DICT_TYPE, SETTINGS, SORT, CREATE_BY, CREATE_DATE, UPDATE_BY, UPDATE_DATE, REMARKS, DEL_FLAG)
values ('5a4a1933c9c844fdba99de043dc8205e', 'aef6f1fc948f4c9ab1c1b780bc471cc2', 'update_by', '更新者', 'varchar2(64)', 'com.krazy.jeesite.modules.modules.sys.entity.User', 'updateBy.id', '0', '0', '1', '1', '0', '0', '=', 'input', null, null, 10, '1', to_timestamp('08-12-2013 11:10:29.138000', 'dd-mm-yyyy hh24:mi:ss.ff'), '1', to_timestamp('08-12-2013 11:28:00.721000', 'dd-mm-yyyy hh24:mi:ss.ff'), null, '0');
insert into GEN_TABLE_COLUMN (ID, GEN_TABLE_ID, NAME, COMMENTS, JDBC_TYPE, JAVA_TYPE, JAVA_FIELD, IS_PK, IS_NULL, IS_INSERT, IS_EDIT, IS_LIST, IS_QUERY, QUERY_TYPE, SHOW_TYPE, DICT_TYPE, SETTINGS, SORT, CREATE_BY, CREATE_DATE, UPDATE_BY, UPDATE_DATE, REMARKS, DEL_FLAG)
values ('eb2e5afd13f147a990d30e68e7f64e12', 'aef6f1fc948f4c9ab1c1b780bc471cc2', 'update_date', '更新时间', 'timestamp(6)', 'java.util.Date', 'updateDate', '0', '0', '1', '1', '1', '0', '=', 'dateselect', null, null, 11, '1', to_timestamp('08-12-2013 11:10:29.140000', 'dd-mm-yyyy hh24:mi:ss.ff'), '1', to_timestamp('08-12-2013 11:28:00.723000', 'dd-mm-yyyy hh24:mi:ss.ff'), null, '0');
insert into GEN_TABLE_COLUMN (ID, GEN_TABLE_ID, NAME, COMMENTS, JDBC_TYPE, JAVA_TYPE, JAVA_FIELD, IS_PK, IS_NULL, IS_INSERT, IS_EDIT, IS_LIST, IS_QUERY, QUERY_TYPE, SHOW_TYPE, DICT_TYPE, SETTINGS, SORT, CREATE_BY, CREATE_DATE, UPDATE_BY, UPDATE_DATE, REMARKS, DEL_FLAG)
values ('8da38dbe5fe54e9bb1f9682c27fbf403', 'aef6f1fc948f4c9ab1c1b780bc471cc2', 'remarks', '备注信息', 'nvarchar2(255)', 'String', 'remarks', '0', '1', '1', '1', '1', '0', '=', 'textarea', null, null, 12, '1', to_timestamp('08-12-2013 11:10:29.142000', 'dd-mm-yyyy hh24:mi:ss.ff'), '1', to_timestamp('08-12-2013 11:28:00.724000', 'dd-mm-yyyy hh24:mi:ss.ff'), null, '0');
insert into GEN_TABLE_COLUMN (ID, GEN_TABLE_ID, NAME, COMMENTS, JDBC_TYPE, JAVA_TYPE, JAVA_FIELD, IS_PK, IS_NULL, IS_INSERT, IS_EDIT, IS_LIST, IS_QUERY, QUERY_TYPE, SHOW_TYPE, DICT_TYPE, SETTINGS, SORT, CREATE_BY, CREATE_DATE, UPDATE_BY, UPDATE_DATE, REMARKS, DEL_FLAG)
values ('35af241859624a01917ab64c3f4f0813', 'aef6f1fc948f4c9ab1c1b780bc471cc2', 'del_flag', '删除标记（0：正常；1：删除）', 'char(1)', 'String', 'delFlag', '0', '0', '1', '0', '0', '0', '=', 'radiobox', 'del_flag', null, 13, '1', to_timestamp('08-12-2013 11:10:29.144000', 'dd-mm-yyyy hh24:mi:ss.ff'), '1', to_timestamp('08-12-2013 11:28:00.726000', 'dd-mm-yyyy hh24:mi:ss.ff'), null, '0');
insert into GEN_TABLE_COLUMN (ID, GEN_TABLE_ID, NAME, COMMENTS, JDBC_TYPE, JAVA_TYPE, JAVA_FIELD, IS_PK, IS_NULL, IS_INSERT, IS_EDIT, IS_LIST, IS_QUERY, QUERY_TYPE, SHOW_TYPE, DICT_TYPE, SETTINGS, SORT, CREATE_BY, CREATE_DATE, UPDATE_BY, UPDATE_DATE, REMARKS, DEL_FLAG)
values ('19c6478b8ff54c60910c2e4fc3d27503', '43d6d5acffa14c258340ce6765e46c6f', 'id', '编号', 'varchar2(64)', 'String', 'id', '1', '0', '1', '0', '0', '0', '=', 'input', null, null, 1, '1', to_timestamp('08-12-2013 11:11:59.747000', 'dd-mm-yyyy hh24:mi:ss.ff'), '1', to_timestamp('08-12-2013 11:26:16.362000', 'dd-mm-yyyy hh24:mi:ss.ff'), null, '0');
insert into GEN_TABLE_COLUMN (ID, GEN_TABLE_ID, NAME, COMMENTS, JDBC_TYPE, JAVA_TYPE, JAVA_FIELD, IS_PK, IS_NULL, IS_INSERT, IS_EDIT, IS_LIST, IS_QUERY, QUERY_TYPE, SHOW_TYPE, DICT_TYPE, SETTINGS, SORT, CREATE_BY, CREATE_DATE, UPDATE_BY, UPDATE_DATE, REMARKS, DEL_FLAG)
values ('8b9de88df53e485d8ef461c4b1824bc1', '43d6d5acffa14c258340ce6765e46c6f', 'user_id', '归属用户', 'varchar2(64)', 'com.krazy.jeesite.modules.modules.sys.entity.User', 'user.id|name', '0', '1', '1', '1', '1', '1', '=', 'userselect', null, null, 2, '1', to_timestamp('08-12-2013 11:11:59.749000', 'dd-mm-yyyy hh24:mi:ss.ff'), '1', to_timestamp('08-12-2013 11:26:16.365000', 'dd-mm-yyyy hh24:mi:ss.ff'), null, '0');
insert into GEN_TABLE_COLUMN (ID, GEN_TABLE_ID, NAME, COMMENTS, JDBC_TYPE, JAVA_TYPE, JAVA_FIELD, IS_PK, IS_NULL, IS_INSERT, IS_EDIT, IS_LIST, IS_QUERY, QUERY_TYPE, SHOW_TYPE, DICT_TYPE, SETTINGS, SORT, CREATE_BY, CREATE_DATE, UPDATE_BY, UPDATE_DATE, REMARKS, DEL_FLAG)
values ('ca68a2d403f0449cbaa1d54198c6f350', '43d6d5acffa14c258340ce6765e46c6f', 'office_id', '归属部门', 'varchar2(64)', 'com.krazy.jeesite.modules.modules.sys.entity.Office', 'office.id|name', '0', '1', '1', '1', '0', '0', '=', 'officeselect', null, null, 3, '1', to_timestamp('08-12-2013 11:11:59.751000', 'dd-mm-yyyy hh24:mi:ss.ff'), '1', to_timestamp('08-12-2013 11:26:16.367000', 'dd-mm-yyyy hh24:mi:ss.ff'), null, '0');
insert into GEN_TABLE_COLUMN (ID, GEN_TABLE_ID, NAME, COMMENTS, JDBC_TYPE, JAVA_TYPE, JAVA_FIELD, IS_PK, IS_NULL, IS_INSERT, IS_EDIT, IS_LIST, IS_QUERY, QUERY_TYPE, SHOW_TYPE, DICT_TYPE, SETTINGS, SORT, CREATE_BY, CREATE_DATE, UPDATE_BY, UPDATE_DATE, REMARKS, DEL_FLAG)
values ('3a7cf23ae48a4c849ceb03feffc7a524', '43d6d5acffa14c258340ce6765e46c6f', 'area_id', '归属区域', 'nvarchar2(64)', 'com.krazy.jeesite.modules.modules.sys.entity.Area', 'area.id|name', '0', '1', '1', '1', '0', '0', '=', 'areaselect', null, null, 4, '1', to_timestamp('08-12-2013 11:11:59.754000', 'dd-mm-yyyy hh24:mi:ss.ff'), '1', to_timestamp('08-12-2013 11:26:16.372000', 'dd-mm-yyyy hh24:mi:ss.ff'), null, '0');
insert into GEN_TABLE_COLUMN (ID, GEN_TABLE_ID, NAME, COMMENTS, JDBC_TYPE, JAVA_TYPE, JAVA_FIELD, IS_PK, IS_NULL, IS_INSERT, IS_EDIT, IS_LIST, IS_QUERY, QUERY_TYPE, SHOW_TYPE, DICT_TYPE, SETTINGS, SORT, CREATE_BY, CREATE_DATE, UPDATE_BY, UPDATE_DATE, REMARKS, DEL_FLAG)
values ('67d0331f809a48ee825602659f0778e8', '43d6d5acffa14c258340ce6765e46c6f', 'name', '名称', 'nvarchar2(100)', 'String', 'name', '0', '1', '1', '1', '1', '1', 'like', 'input', null, null, 5, '1', to_timestamp('08-12-2013 11:11:59.756000', 'dd-mm-yyyy hh24:mi:ss.ff'), '1', to_timestamp('08-12-2013 11:26:16.374000', 'dd-mm-yyyy hh24:mi:ss.ff'), null, '0');
insert into GEN_TABLE_COLUMN (ID, GEN_TABLE_ID, NAME, COMMENTS, JDBC_TYPE, JAVA_TYPE, JAVA_FIELD, IS_PK, IS_NULL, IS_INSERT, IS_EDIT, IS_LIST, IS_QUERY, QUERY_TYPE, SHOW_TYPE, DICT_TYPE, SETTINGS, SORT, CREATE_BY, CREATE_DATE, UPDATE_BY, UPDATE_DATE, REMARKS, DEL_FLAG)
values ('d5c2d932ae904aa8a9f9ef34cd36fb0b', '43d6d5acffa14c258340ce6765e46c6f', 'sex', '性别', 'char(1)', 'String', 'sex', '0', '1', '1', '1', '0', '1', '=', 'select', 'sex', null, 6, '1', to_timestamp('08-12-2013 11:11:59.757000', 'dd-mm-yyyy hh24:mi:ss.ff'), '1', to_timestamp('08-12-2013 11:26:16.376000', 'dd-mm-yyyy hh24:mi:ss.ff'), null, '0');
insert into GEN_TABLE_COLUMN (ID, GEN_TABLE_ID, NAME, COMMENTS, JDBC_TYPE, JAVA_TYPE, JAVA_FIELD, IS_PK, IS_NULL, IS_INSERT, IS_EDIT, IS_LIST, IS_QUERY, QUERY_TYPE, SHOW_TYPE, DICT_TYPE, SETTINGS, SORT, CREATE_BY, CREATE_DATE, UPDATE_BY, UPDATE_DATE, REMARKS, DEL_FLAG)
values ('1ac6562f753d4e599693840651ab2bf7', '43d6d5acffa14c258340ce6765e46c6f', 'in_date', '加入日期', 'date(7)', 'java.util.Date', 'inDate', '0', '1', '1', '1', '0', '0', '=', 'dateselect', null, null, 7, '1', to_timestamp('08-12-2013 11:11:59.758000', 'dd-mm-yyyy hh24:mi:ss.ff'), '1', to_timestamp('08-12-2013 11:26:16.378000', 'dd-mm-yyyy hh24:mi:ss.ff'), null, '0');
insert into GEN_TABLE_COLUMN (ID, GEN_TABLE_ID, NAME, COMMENTS, JDBC_TYPE, JAVA_TYPE, JAVA_FIELD, IS_PK, IS_NULL, IS_INSERT, IS_EDIT, IS_LIST, IS_QUERY, QUERY_TYPE, SHOW_TYPE, DICT_TYPE, SETTINGS, SORT, CREATE_BY, CREATE_DATE, UPDATE_BY, UPDATE_DATE, REMARKS, DEL_FLAG)
values ('8b48774cfe184913b8b5eb17639cf12d', '43d6d5acffa14c258340ce6765e46c6f', 'create_by', '创建者', 'varchar2(64)', 'com.krazy.jeesite.modules.modules.sys.entity.User', 'createBy.id', '0', '0', '1', '0', '0', '0', '=', 'input', null, null, 8, '1', to_timestamp('08-12-2013 11:11:59.760000', 'dd-mm-yyyy hh24:mi:ss.ff'), '1', to_timestamp('08-12-2013 11:26:16.379000', 'dd-mm-yyyy hh24:mi:ss.ff'), null, '0');
insert into GEN_TABLE_COLUMN (ID, GEN_TABLE_ID, NAME, COMMENTS, JDBC_TYPE, JAVA_TYPE, JAVA_FIELD, IS_PK, IS_NULL, IS_INSERT, IS_EDIT, IS_LIST, IS_QUERY, QUERY_TYPE, SHOW_TYPE, DICT_TYPE, SETTINGS, SORT, CREATE_BY, CREATE_DATE, UPDATE_BY, UPDATE_DATE, REMARKS, DEL_FLAG)
values ('4c8ef12cb6924b9ba44048ba9913150b', '43d6d5acffa14c258340ce6765e46c6f', 'create_date', '创建时间', 'timestamp(6)', 'java.util.Date', 'createDate', '0', '0', '1', '0', '0', '0', '=', 'dateselect', null, null, 9, '1', to_timestamp('08-12-2013 11:11:59.761000', 'dd-mm-yyyy hh24:mi:ss.ff'), '1', to_timestamp('08-12-2013 11:26:16.381000', 'dd-mm-yyyy hh24:mi:ss.ff'), null, '0');
insert into GEN_TABLE_COLUMN (ID, GEN_TABLE_ID, NAME, COMMENTS, JDBC_TYPE, JAVA_TYPE, JAVA_FIELD, IS_PK, IS_NULL, IS_INSERT, IS_EDIT, IS_LIST, IS_QUERY, QUERY_TYPE, SHOW_TYPE, DICT_TYPE, SETTINGS, SORT, CREATE_BY, CREATE_DATE, UPDATE_BY, UPDATE_DATE, REMARKS, DEL_FLAG)
values ('21756504ffdc487eb167a823f89c0c06', '43d6d5acffa14c258340ce6765e46c6f', 'update_by', '更新者', 'varchar2(64)', 'com.krazy.jeesite.modules.modules.sys.entity.User', 'updateBy.id', '0', '0', '1', '1', '0', '0', '=', 'input', null, null, 10, '1', to_timestamp('08-12-2013 11:11:59.763000', 'dd-mm-yyyy hh24:mi:ss.ff'), '1', to_timestamp('08-12-2013 11:26:16.383000', 'dd-mm-yyyy hh24:mi:ss.ff'), null, '0');
insert into GEN_TABLE_COLUMN (ID, GEN_TABLE_ID, NAME, COMMENTS, JDBC_TYPE, JAVA_TYPE, JAVA_FIELD, IS_PK, IS_NULL, IS_INSERT, IS_EDIT, IS_LIST, IS_QUERY, QUERY_TYPE, SHOW_TYPE, DICT_TYPE, SETTINGS, SORT, CREATE_BY, CREATE_DATE, UPDATE_BY, UPDATE_DATE, REMARKS, DEL_FLAG)
values ('3d9c32865bb44e85af73381df0ffbf3d', '43d6d5acffa14c258340ce6765e46c6f', 'update_date', '更新时间', 'timestamp(6)', 'java.util.Date', 'updateDate', '0', '0', '1', '1', '1', '0', '=', 'dateselect', null, null, 11, '1', to_timestamp('08-12-2013 11:11:59.764000', 'dd-mm-yyyy hh24:mi:ss.ff'), '1', to_timestamp('08-12-2013 11:26:16.385000', 'dd-mm-yyyy hh24:mi:ss.ff'), null, '0');
insert into GEN_TABLE_COLUMN (ID, GEN_TABLE_ID, NAME, COMMENTS, JDBC_TYPE, JAVA_TYPE, JAVA_FIELD, IS_PK, IS_NULL, IS_INSERT, IS_EDIT, IS_LIST, IS_QUERY, QUERY_TYPE, SHOW_TYPE, DICT_TYPE, SETTINGS, SORT, CREATE_BY, CREATE_DATE, UPDATE_BY, UPDATE_DATE, REMARKS, DEL_FLAG)
values ('cb9c0ec3da26432d9cbac05ede0fd1d0', '43d6d5acffa14c258340ce6765e46c6f', 'remarks', '备注信息', 'nvarchar2(255)', 'String', 'remarks', '0', '1', '1', '1', '1', '0', '=', 'textarea', null, null, 12, '1', to_timestamp('08-12-2013 11:11:59.765000', 'dd-mm-yyyy hh24:mi:ss.ff'), '1', to_timestamp('08-12-2013 11:26:16.386000', 'dd-mm-yyyy hh24:mi:ss.ff'), null, '0');
insert into GEN_TABLE_COLUMN (ID, GEN_TABLE_ID, NAME, COMMENTS, JDBC_TYPE, JAVA_TYPE, JAVA_FIELD, IS_PK, IS_NULL, IS_INSERT, IS_EDIT, IS_LIST, IS_QUERY, QUERY_TYPE, SHOW_TYPE, DICT_TYPE, SETTINGS, SORT, CREATE_BY, CREATE_DATE, UPDATE_BY, UPDATE_DATE, REMARKS, DEL_FLAG)
values ('e8d11127952d4aa288bb3901fc83127f', '43d6d5acffa14c258340ce6765e46c6f', 'del_flag', '删除标记（0：正常；1：删除）', 'char(1)', 'String', 'delFlag', '0', '0', '1', '0', '0', '0', '=', 'radiobox', 'del_flag', null, 13, '1', to_timestamp('08-12-2013 11:11:59.767000', 'dd-mm-yyyy hh24:mi:ss.ff'), '1', to_timestamp('08-12-2013 11:26:16.388000', 'dd-mm-yyyy hh24:mi:ss.ff'), null, '0');
insert into GEN_TABLE_COLUMN (ID, GEN_TABLE_ID, NAME, COMMENTS, JDBC_TYPE, JAVA_TYPE, JAVA_FIELD, IS_PK, IS_NULL, IS_INSERT, IS_EDIT, IS_LIST, IS_QUERY, QUERY_TYPE, SHOW_TYPE, DICT_TYPE, SETTINGS, SORT, CREATE_BY, CREATE_DATE, UPDATE_BY, UPDATE_DATE, REMARKS, DEL_FLAG)
values ('33152ce420904594b3eac796a27f0560', '6e05c389f3c6415ea34e55e9dfb28934', 'id', '编号', 'varchar2(64)', 'String', 'id', '1', '0', '1', '0', '0', '0', '=', 'input', null, null, 1, '1', to_timestamp('08-12-2013 11:12:57.962000', 'dd-mm-yyyy hh24:mi:ss.ff'), '1', to_timestamp('08-12-2013 11:30:22.326000', 'dd-mm-yyyy hh24:mi:ss.ff'), null, '0');
insert into GEN_TABLE_COLUMN (ID, GEN_TABLE_ID, NAME, COMMENTS, JDBC_TYPE, JAVA_TYPE, JAVA_FIELD, IS_PK, IS_NULL, IS_INSERT, IS_EDIT, IS_LIST, IS_QUERY, QUERY_TYPE, SHOW_TYPE, DICT_TYPE, SETTINGS, SORT, CREATE_BY, CREATE_DATE, UPDATE_BY, UPDATE_DATE, REMARKS, DEL_FLAG)
values ('68345713bef3445c906f70e68f55de38', '6e05c389f3c6415ea34e55e9dfb28934', 'test_data_main_id', '业务主表', 'varchar2(64)', 'String', 'testDataMain.id', '0', '1', '1', '1', '0', '0', '=', 'input', null, null, 2, '1', to_timestamp('08-12-2013 11:12:57.964000', 'dd-mm-yyyy hh24:mi:ss.ff'), '1', to_timestamp('08-12-2013 11:30:22.327000', 'dd-mm-yyyy hh24:mi:ss.ff'), null, '0');
insert into GEN_TABLE_COLUMN (ID, GEN_TABLE_ID, NAME, COMMENTS, JDBC_TYPE, JAVA_TYPE, JAVA_FIELD, IS_PK, IS_NULL, IS_INSERT, IS_EDIT, IS_LIST, IS_QUERY, QUERY_TYPE, SHOW_TYPE, DICT_TYPE, SETTINGS, SORT, CREATE_BY, CREATE_DATE, UPDATE_BY, UPDATE_DATE, REMARKS, DEL_FLAG)
values ('e64050a2ebf041faa16f12dda5dcf784', '6e05c389f3c6415ea34e55e9dfb28934', 'name', '名称', 'nvarchar2(100)', 'String', 'name', '0', '1', '1', '1', '1', '1', 'like', 'input', null, null, 3, '1', to_timestamp('08-12-2013 11:12:57.966000', 'dd-mm-yyyy hh24:mi:ss.ff'), '1', to_timestamp('08-12-2013 11:30:22.329000', 'dd-mm-yyyy hh24:mi:ss.ff'), null, '0');
insert into GEN_TABLE_COLUMN (ID, GEN_TABLE_ID, NAME, COMMENTS, JDBC_TYPE, JAVA_TYPE, JAVA_FIELD, IS_PK, IS_NULL, IS_INSERT, IS_EDIT, IS_LIST, IS_QUERY, QUERY_TYPE, SHOW_TYPE, DICT_TYPE, SETTINGS, SORT, CREATE_BY, CREATE_DATE, UPDATE_BY, UPDATE_DATE, REMARKS, DEL_FLAG)
values ('12fa38dd986e41908f7fefa5839d1220', '6e05c389f3c6415ea34e55e9dfb28934', 'create_by', '创建者', 'varchar2(64)', 'com.krazy.jeesite.modules.modules.sys.entity.User', 'createBy.id', '0', '0', '1', '0', '0', '0', '=', 'input', null, null, 4, '1', to_timestamp('08-12-2013 11:12:57.967000', 'dd-mm-yyyy hh24:mi:ss.ff'), '1', to_timestamp('08-12-2013 11:30:22.330000', 'dd-mm-yyyy hh24:mi:ss.ff'), null, '0');
insert into GEN_TABLE_COLUMN (ID, GEN_TABLE_ID, NAME, COMMENTS, JDBC_TYPE, JAVA_TYPE, JAVA_FIELD, IS_PK, IS_NULL, IS_INSERT, IS_EDIT, IS_LIST, IS_QUERY, QUERY_TYPE, SHOW_TYPE, DICT_TYPE, SETTINGS, SORT, CREATE_BY, CREATE_DATE, UPDATE_BY, UPDATE_DATE, REMARKS, DEL_FLAG)
values ('8b7cf0525519474ebe1de9e587eb7067', '6e05c389f3c6415ea34e55e9dfb28934', 'create_date', '创建时间', 'timestamp(6)', 'java.util.Date', 'createDate', '0', '0', '1', '0', '0', '0', '=', 'dateselect', null, null, 5, '1', to_timestamp('08-12-2013 11:12:57.968000', 'dd-mm-yyyy hh24:mi:ss.ff'), '1', to_timestamp('08-12-2013 11:30:22.332000', 'dd-mm-yyyy hh24:mi:ss.ff'), null, '0');
insert into GEN_TABLE_COLUMN (ID, GEN_TABLE_ID, NAME, COMMENTS, JDBC_TYPE, JAVA_TYPE, JAVA_FIELD, IS_PK, IS_NULL, IS_INSERT, IS_EDIT, IS_LIST, IS_QUERY, QUERY_TYPE, SHOW_TYPE, DICT_TYPE, SETTINGS, SORT, CREATE_BY, CREATE_DATE, UPDATE_BY, UPDATE_DATE, REMARKS, DEL_FLAG)
values ('56fa71c0bd7e4132931874e548dc9ba5', '6e05c389f3c6415ea34e55e9dfb28934', 'update_by', '更新者', 'varchar2(64)', 'com.krazy.jeesite.modules.modules.sys.entity.User', 'updateBy.id', '0', '0', '1', '1', '0', '0', '=', 'input', null, null, 6, '1', to_timestamp('08-12-2013 11:12:57.969000', 'dd-mm-yyyy hh24:mi:ss.ff'), '1', to_timestamp('08-12-2013 11:30:22.333000', 'dd-mm-yyyy hh24:mi:ss.ff'), null, '0');
insert into GEN_TABLE_COLUMN (ID, GEN_TABLE_ID, NAME, COMMENTS, JDBC_TYPE, JAVA_TYPE, JAVA_FIELD, IS_PK, IS_NULL, IS_INSERT, IS_EDIT, IS_LIST, IS_QUERY, QUERY_TYPE, SHOW_TYPE, DICT_TYPE, SETTINGS, SORT, CREATE_BY, CREATE_DATE, UPDATE_BY, UPDATE_DATE, REMARKS, DEL_FLAG)
values ('652491500f2641ffa7caf95a93e64d34', '6e05c389f3c6415ea34e55e9dfb28934', 'update_date', '更新时间', 'timestamp(6)', 'java.util.Date', 'updateDate', '0', '0', '1', '1', '1', '0', '=', 'dateselect', null, null, 7, '1', to_timestamp('08-12-2013 11:12:57.971000', 'dd-mm-yyyy hh24:mi:ss.ff'), '1', to_timestamp('08-12-2013 11:30:22.334000', 'dd-mm-yyyy hh24:mi:ss.ff'), null, '0');
insert into GEN_TABLE_COLUMN (ID, GEN_TABLE_ID, NAME, COMMENTS, JDBC_TYPE, JAVA_TYPE, JAVA_FIELD, IS_PK, IS_NULL, IS_INSERT, IS_EDIT, IS_LIST, IS_QUERY, QUERY_TYPE, SHOW_TYPE, DICT_TYPE, SETTINGS, SORT, CREATE_BY, CREATE_DATE, UPDATE_BY, UPDATE_DATE, REMARKS, DEL_FLAG)
values ('7f871058d94c4d9a89084be7c9ce806d', '6e05c389f3c6415ea34e55e9dfb28934', 'remarks', '备注信息', 'nvarchar2(255)', 'String', 'remarks', '0', '1', '1', '1', '1', '0', '=', 'input', null, null, 8, '1', to_timestamp('08-12-2013 11:12:57.973000', 'dd-mm-yyyy hh24:mi:ss.ff'), '1', to_timestamp('08-12-2013 11:30:22.335000', 'dd-mm-yyyy hh24:mi:ss.ff'), null, '0');
insert into GEN_TABLE_COLUMN (ID, GEN_TABLE_ID, NAME, COMMENTS, JDBC_TYPE, JAVA_TYPE, JAVA_FIELD, IS_PK, IS_NULL, IS_INSERT, IS_EDIT, IS_LIST, IS_QUERY, QUERY_TYPE, SHOW_TYPE, DICT_TYPE, SETTINGS, SORT, CREATE_BY, CREATE_DATE, UPDATE_BY, UPDATE_DATE, REMARKS, DEL_FLAG)
values ('53d65a3d306d4fac9e561db9d3c66912', '6e05c389f3c6415ea34e55e9dfb28934', 'del_flag', '删除标记（0：正常；1：删除）', 'char(1)', 'String', 'delFlag', '0', '0', '1', '0', '0', '0', '=', 'radiobox', 'del_flag', null, 9, '1', to_timestamp('08-12-2013 11:12:57.975000', 'dd-mm-yyyy hh24:mi:ss.ff'), '1', to_timestamp('08-12-2013 11:30:22.337000', 'dd-mm-yyyy hh24:mi:ss.ff'), null, '0');
insert into GEN_TABLE_COLUMN (ID, GEN_TABLE_ID, NAME, COMMENTS, JDBC_TYPE, JAVA_TYPE, JAVA_FIELD, IS_PK, IS_NULL, IS_INSERT, IS_EDIT, IS_LIST, IS_QUERY, QUERY_TYPE, SHOW_TYPE, DICT_TYPE, SETTINGS, SORT, CREATE_BY, CREATE_DATE, UPDATE_BY, UPDATE_DATE, REMARKS, DEL_FLAG)
values ('cfcfa06ea61749c9b4c4dbc507e0e580', 'f6e4dafaa72f4c509636484715f33a96', 'id', '编号', 'varchar2(64)', 'String', 'id', '1', '0', '1', '0', '0', '0', '=', 'input', null, null, 1, '1', to_timestamp('08-12-2013 11:16:19.095000', 'dd-mm-yyyy hh24:mi:ss.ff'), '1', to_timestamp('08-12-2013 13:49:47.756000', 'dd-mm-yyyy hh24:mi:ss.ff'), null, '0');
insert into GEN_TABLE_COLUMN (ID, GEN_TABLE_ID, NAME, COMMENTS, JDBC_TYPE, JAVA_TYPE, JAVA_FIELD, IS_PK, IS_NULL, IS_INSERT, IS_EDIT, IS_LIST, IS_QUERY, QUERY_TYPE, SHOW_TYPE, DICT_TYPE, SETTINGS, SORT, CREATE_BY, CREATE_DATE, UPDATE_BY, UPDATE_DATE, REMARKS, DEL_FLAG)
values ('9a012c1d2f934dbf996679adb7cc827a', 'f6e4dafaa72f4c509636484715f33a96', 'parent_id', '父级编号', 'varchar2(64)', 'This', 'parent.id|name', '0', '0', '1', '1', '0', '0', '=', 'treeselect', null, null, 2, '1', to_timestamp('08-12-2013 11:16:19.096000', 'dd-mm-yyyy hh24:mi:ss.ff'), '1', to_timestamp('08-12-2013 13:49:47.759000', 'dd-mm-yyyy hh24:mi:ss.ff'), null, '0');
insert into GEN_TABLE_COLUMN (ID, GEN_TABLE_ID, NAME, COMMENTS, JDBC_TYPE, JAVA_TYPE, JAVA_FIELD, IS_PK, IS_NULL, IS_INSERT, IS_EDIT, IS_LIST, IS_QUERY, QUERY_TYPE, SHOW_TYPE, DICT_TYPE, SETTINGS, SORT, CREATE_BY, CREATE_DATE, UPDATE_BY, UPDATE_DATE, REMARKS, DEL_FLAG)
values ('24bbdc0a555e4412a106ab1c5f03008e', 'f6e4dafaa72f4c509636484715f33a96', 'parent_ids', '所有父级编号', 'varchar2(2000)', 'String', 'parentIds', '0', '0', '1', '1', '0', '0', 'like', 'input', null, null, 3, '1', to_timestamp('08-12-2013 11:16:19.098000', 'dd-mm-yyyy hh24:mi:ss.ff'), '1', to_timestamp('08-12-2013 13:49:47.761000', 'dd-mm-yyyy hh24:mi:ss.ff'), null, '0');
insert into GEN_TABLE_COLUMN (ID, GEN_TABLE_ID, NAME, COMMENTS, JDBC_TYPE, JAVA_TYPE, JAVA_FIELD, IS_PK, IS_NULL, IS_INSERT, IS_EDIT, IS_LIST, IS_QUERY, QUERY_TYPE, SHOW_TYPE, DICT_TYPE, SETTINGS, SORT, CREATE_BY, CREATE_DATE, UPDATE_BY, UPDATE_DATE, REMARKS, DEL_FLAG)
values ('633f5a49ec974c099158e7b3e6bfa930', 'f6e4dafaa72f4c509636484715f33a96', 'name', '名称', 'nvarchar2(100)', 'String', 'name', '0', '0', '1', '1', '1', '1', 'like', 'input', null, null, 4, '1', to_timestamp('08-12-2013 11:16:19.115000', 'dd-mm-yyyy hh24:mi:ss.ff'), '1', to_timestamp('08-12-2013 13:49:47.763000', 'dd-mm-yyyy hh24:mi:ss.ff'), null, '0');
insert into GEN_TABLE_COLUMN (ID, GEN_TABLE_ID, NAME, COMMENTS, JDBC_TYPE, JAVA_TYPE, JAVA_FIELD, IS_PK, IS_NULL, IS_INSERT, IS_EDIT, IS_LIST, IS_QUERY, QUERY_TYPE, SHOW_TYPE, DICT_TYPE, SETTINGS, SORT, CREATE_BY, CREATE_DATE, UPDATE_BY, UPDATE_DATE, REMARKS, DEL_FLAG)
values ('6763ff6dc7cd4c668e76cf9b697d3ff6', 'f6e4dafaa72f4c509636484715f33a96', 'sort', '排序', 'number(10)', 'Integer', 'sort', '0', '0', '1', '1', '1', '0', '=', 'input', null, null, 5, '1', to_timestamp('08-12-2013 11:16:19.116000', 'dd-mm-yyyy hh24:mi:ss.ff'), '1', to_timestamp('08-12-2013 13:49:47.764000', 'dd-mm-yyyy hh24:mi:ss.ff'), null, '0');
insert into GEN_TABLE_COLUMN (ID, GEN_TABLE_ID, NAME, COMMENTS, JDBC_TYPE, JAVA_TYPE, JAVA_FIELD, IS_PK, IS_NULL, IS_INSERT, IS_EDIT, IS_LIST, IS_QUERY, QUERY_TYPE, SHOW_TYPE, DICT_TYPE, SETTINGS, SORT, CREATE_BY, CREATE_DATE, UPDATE_BY, UPDATE_DATE, REMARKS, DEL_FLAG)
values ('195ee9241f954d008fe01625f4adbfef', 'f6e4dafaa72f4c509636484715f33a96', 'create_by', '创建者', 'varchar2(64)', 'com.krazy.jeesite.modules.modules.sys.entity.User', 'createBy.id', '0', '0', '1', '0', '0', '0', '=', 'input', null, null, 6, '1', to_timestamp('08-12-2013 11:16:19.117000', 'dd-mm-yyyy hh24:mi:ss.ff'), '1', to_timestamp('08-12-2013 13:49:47.766000', 'dd-mm-yyyy hh24:mi:ss.ff'), null, '0');
insert into GEN_TABLE_COLUMN (ID, GEN_TABLE_ID, NAME, COMMENTS, JDBC_TYPE, JAVA_TYPE, JAVA_FIELD, IS_PK, IS_NULL, IS_INSERT, IS_EDIT, IS_LIST, IS_QUERY, QUERY_TYPE, SHOW_TYPE, DICT_TYPE, SETTINGS, SORT, CREATE_BY, CREATE_DATE, UPDATE_BY, UPDATE_DATE, REMARKS, DEL_FLAG)
values ('92481c16a0b94b0e8bba16c3c54eb1e4', 'f6e4dafaa72f4c509636484715f33a96', 'create_date', '创建时间', 'timestamp(6)', 'java.util.Date', 'createDate', '0', '0', '1', '0', '0', '0', '=', 'dateselect', null, null, 7, '1', to_timestamp('08-12-2013 11:16:19.118000', 'dd-mm-yyyy hh24:mi:ss.ff'), '1', to_timestamp('08-12-2013 13:49:47.768000', 'dd-mm-yyyy hh24:mi:ss.ff'), null, '0');
insert into GEN_TABLE_COLUMN (ID, GEN_TABLE_ID, NAME, COMMENTS, JDBC_TYPE, JAVA_TYPE, JAVA_FIELD, IS_PK, IS_NULL, IS_INSERT, IS_EDIT, IS_LIST, IS_QUERY, QUERY_TYPE, SHOW_TYPE, DICT_TYPE, SETTINGS, SORT, CREATE_BY, CREATE_DATE, UPDATE_BY, UPDATE_DATE, REMARKS, DEL_FLAG)
values ('bb1256a8d1b741f6936d8fed06f45eed', 'f6e4dafaa72f4c509636484715f33a96', 'update_by', '更新者', 'varchar2(64)', 'com.krazy.jeesite.modules.modules.sys.entity.User', 'updateBy.id', '0', '0', '1', '1', '0', '0', '=', 'input', null, null, 8, '1', to_timestamp('08-12-2013 11:16:19.119000', 'dd-mm-yyyy hh24:mi:ss.ff'), '1', to_timestamp('08-12-2013 13:49:47.770000', 'dd-mm-yyyy hh24:mi:ss.ff'), null, '0');
insert into GEN_TABLE_COLUMN (ID, GEN_TABLE_ID, NAME, COMMENTS, JDBC_TYPE, JAVA_TYPE, JAVA_FIELD, IS_PK, IS_NULL, IS_INSERT, IS_EDIT, IS_LIST, IS_QUERY, QUERY_TYPE, SHOW_TYPE, DICT_TYPE, SETTINGS, SORT, CREATE_BY, CREATE_DATE, UPDATE_BY, UPDATE_DATE, REMARKS, DEL_FLAG)
values ('416c76d2019b4f76a96d8dc3a8faf84c', 'f6e4dafaa72f4c509636484715f33a96', 'update_date', '更新时间', 'timestamp(6)', 'java.util.Date', 'updateDate', '0', '0', '1', '1', '1', '0', '=', 'dateselect', null, null, 9, '1', to_timestamp('08-12-2013 11:16:19.120000', 'dd-mm-yyyy hh24:mi:ss.ff'), '1', to_timestamp('08-12-2013 13:49:47.772000', 'dd-mm-yyyy hh24:mi:ss.ff'), null, '0');
insert into GEN_TABLE_COLUMN (ID, GEN_TABLE_ID, NAME, COMMENTS, JDBC_TYPE, JAVA_TYPE, JAVA_FIELD, IS_PK, IS_NULL, IS_INSERT, IS_EDIT, IS_LIST, IS_QUERY, QUERY_TYPE, SHOW_TYPE, DICT_TYPE, SETTINGS, SORT, CREATE_BY, CREATE_DATE, UPDATE_BY, UPDATE_DATE, REMARKS, DEL_FLAG)
values ('f5ed8c82bad0413fbfcccefa95931358', 'f6e4dafaa72f4c509636484715f33a96', 'remarks', '备注信息', 'nvarchar2(255)', 'String', 'remarks', '0', '1', '1', '1', '1', '0', '=', 'textarea', null, null, 10, '1', to_timestamp('08-12-2013 11:16:19.121000', 'dd-mm-yyyy hh24:mi:ss.ff'), '1', to_timestamp('08-12-2013 13:49:47.774000', 'dd-mm-yyyy hh24:mi:ss.ff'), null, '0');
insert into GEN_TABLE_COLUMN (ID, GEN_TABLE_ID, NAME, COMMENTS, JDBC_TYPE, JAVA_TYPE, JAVA_FIELD, IS_PK, IS_NULL, IS_INSERT, IS_EDIT, IS_LIST, IS_QUERY, QUERY_TYPE, SHOW_TYPE, DICT_TYPE, SETTINGS, SORT, CREATE_BY, CREATE_DATE, UPDATE_BY, UPDATE_DATE, REMARKS, DEL_FLAG)
values ('46e6d8283270493687085d29efdecb05', 'f6e4dafaa72f4c509636484715f33a96', 'del_flag', '删除标记（0：正常；1：删除）', 'char(1)', 'String', 'delFlag', '0', '0', '1', '0', '0', '0', '=', 'radiobox', 'del_flag', null, 11, '1', to_timestamp('08-12-2013 11:16:19.122000', 'dd-mm-yyyy hh24:mi:ss.ff'), '1', to_timestamp('08-12-2013 13:49:47.775000', 'dd-mm-yyyy hh24:mi:ss.ff'), null, '0');
commit;
/*Table structure for table `gen_template` */

CREATE TABLE gen_template
(
	id varchar2(64) NOT NULL,
	name nvarchar2(200),
	category varchar2(2000),
	file_path varchar2(500),
	file_name varchar2(200),
	content clob,
	create_by varchar2(64),
	create_date timestamp,
	update_by varchar2(64),
	update_date timestamp,
	remarks nvarchar2(255),
	del_flag char(1) DEFAULT '0' NOT NULL,
	PRIMARY KEY (id)
);

COMMENT ON TABLE gen_template IS '代码模板表';
COMMENT ON COLUMN gen_template.id IS '编号';
COMMENT ON COLUMN gen_template.name IS '名称';
COMMENT ON COLUMN gen_template.category IS '分类';
COMMENT ON COLUMN gen_template.file_path IS '生成文件路径';
COMMENT ON COLUMN gen_template.file_name IS '生成文件名';
COMMENT ON COLUMN gen_template.content IS '内容';
COMMENT ON COLUMN gen_template.create_by IS '创建者';
COMMENT ON COLUMN gen_template.create_date IS '创建时间';
COMMENT ON COLUMN gen_template.update_by IS '更新者';
COMMENT ON COLUMN gen_template.update_date IS '更新时间';
COMMENT ON COLUMN gen_template.remarks IS '备注信息';
COMMENT ON COLUMN gen_template.del_flag IS '删除标记（0：正常；1：删除）';


/*Data for the table `gen_template` */


/*Table structure for table `oa_leave` */
CREATE TABLE oa_leave
(
	id varchar2(64) NOT NULL,
	process_instance_id varchar2(64),
	start_time timestamp,
	end_time timestamp,
	leave_type varchar2(20),
	reason nvarchar2(255),
	apply_time timestamp,
	reality_start_time timestamp,
	reality_end_time timestamp,
	create_by varchar2(64) NOT NULL,
	create_date timestamp NOT NULL,
	update_by varchar2(64) NOT NULL,
	update_date timestamp NOT NULL,
	remarks nvarchar2(255),
	del_flag char(1) DEFAULT '0' NOT NULL,
	PRIMARY KEY (id)
);

COMMENT ON TABLE oa_leave IS '请假流程表';
COMMENT ON COLUMN oa_leave.id IS '编号';
COMMENT ON COLUMN oa_leave.process_instance_id IS '流程实例编号';
COMMENT ON COLUMN oa_leave.start_time IS '开始时间';
COMMENT ON COLUMN oa_leave.end_time IS '结束时间';
COMMENT ON COLUMN oa_leave.leave_type IS '请假类型';
COMMENT ON COLUMN oa_leave.reason IS '请假理由';
COMMENT ON COLUMN oa_leave.apply_time IS '申请时间';
COMMENT ON COLUMN oa_leave.reality_start_time IS '实际开始时间';
COMMENT ON COLUMN oa_leave.reality_end_time IS '实际结束时间';
COMMENT ON COLUMN oa_leave.create_by IS '创建者';
COMMENT ON COLUMN oa_leave.create_date IS '创建时间';
COMMENT ON COLUMN oa_leave.update_by IS '更新者';
COMMENT ON COLUMN oa_leave.update_date IS '更新时间';
COMMENT ON COLUMN oa_leave.remarks IS '备注信息';
COMMENT ON COLUMN oa_leave.del_flag IS '删除标记';

/*Data for the table `oa_leave` */

/*Table structure for table `oa_notify` */
CREATE TABLE oa_notify
(
	id varchar2(64) NOT NULL,
	type char(1),
	title nvarchar2(200),
	content nvarchar2(2000),
	files nvarchar2(2000),
	status char(1),
	create_by varchar2(64) NOT NULL,
	create_date timestamp NOT NULL,
	update_by varchar2(64) NOT NULL,
	update_date timestamp NOT NULL,
	remarks nvarchar2(255),
	del_flag char(1) DEFAULT '0' NOT NULL,
	PRIMARY KEY (id)
);

COMMENT ON TABLE oa_notify IS '通知通告';
COMMENT ON COLUMN oa_notify.id IS '编号';
COMMENT ON COLUMN oa_notify.type IS '类型';
COMMENT ON COLUMN oa_notify.title IS '标题';
COMMENT ON COLUMN oa_notify.content IS '内容';
COMMENT ON COLUMN oa_notify.files IS '附件';
COMMENT ON COLUMN oa_notify.status IS '状态';
COMMENT ON COLUMN oa_notify.create_by IS '创建者';
COMMENT ON COLUMN oa_notify.create_date IS '创建时间';
COMMENT ON COLUMN oa_notify.update_by IS '更新者';
COMMENT ON COLUMN oa_notify.update_date IS '更新时间';
COMMENT ON COLUMN oa_notify.remarks IS '备注信息';
COMMENT ON COLUMN oa_notify.del_flag IS '删除标记';

/*Data for the table `oa_notify` */

/*Table structure for table `oa_notify_record` */

CREATE TABLE oa_notify_record
(
	id varchar2(64) NOT NULL,
	oa_notify_id varchar2(64),
	user_id varchar2(64),
	read_flag char(1) DEFAULT '0',
	read_date date,
	PRIMARY KEY (id)
);
COMMENT ON TABLE oa_notify_record IS '通知通告发送记录';
COMMENT ON COLUMN oa_notify_record.id IS '编号';
COMMENT ON COLUMN oa_notify_record.oa_notify_id IS '通知通告ID';
COMMENT ON COLUMN oa_notify_record.user_id IS '接受人';
COMMENT ON COLUMN oa_notify_record.read_flag IS '阅读标记';
COMMENT ON COLUMN oa_notify_record.read_date IS '阅读时间';


/*Data for the table `oa_notify_record` */

/*Table structure for table `oa_test_audit` */
CREATE TABLE OA_TEST_AUDIT
(
	id varchar2(64) NOT NULL,
	PROC_INS_ID varchar2(64),
	USER_ID varchar2(64),
	OFFICE_ID varchar2(64),
	POST nvarchar2(255),
	AGE char(1),
	EDU nvarchar2(255),
	CONTENT nvarchar2(255),
	OLDA varchar2(255),
	OLDB varchar2(255),
	OLDC varchar2(255),
	NEWA varchar2(255),
	NEWB varchar2(255),
	NEWC varchar2(255),
	ADD_NUM varchar2(255),
	EXE_DATE varchar2(255),
	HR_TEXT nvarchar2(255),
	LEAD_TEXT nvarchar2(255),
	MAIN_LEAD_TEXT nvarchar2(255),
	create_by varchar2(64) NOT NULL,
	create_date timestamp NOT NULL,
	update_by varchar2(64) NOT NULL,
	update_date timestamp NOT NULL,
	remarks nvarchar2(255),
	del_flag char(1) DEFAULT '0' NOT NULL,
	CONSTRAINT SYS_C0016476 PRIMARY KEY (id)
);

COMMENT ON TABLE OA_TEST_AUDIT IS '审批流程测试表';
COMMENT ON COLUMN OA_TEST_AUDIT.id IS '编号';
COMMENT ON COLUMN OA_TEST_AUDIT.PROC_INS_ID IS '流程实例ID';
COMMENT ON COLUMN OA_TEST_AUDIT.USER_ID IS '变动用户';
COMMENT ON COLUMN OA_TEST_AUDIT.OFFICE_ID IS '归属部门';
COMMENT ON COLUMN OA_TEST_AUDIT.POST IS '岗位';
COMMENT ON COLUMN OA_TEST_AUDIT.AGE IS '性别';
COMMENT ON COLUMN OA_TEST_AUDIT.EDU IS '学历';
COMMENT ON COLUMN OA_TEST_AUDIT.CONTENT IS '调整原因';
COMMENT ON COLUMN OA_TEST_AUDIT.OLDA IS '现行标准 薪酬档级';
COMMENT ON COLUMN OA_TEST_AUDIT.OLDB IS '现行标准 月工资额';
COMMENT ON COLUMN OA_TEST_AUDIT.OLDC IS '现行标准 年薪总额';
COMMENT ON COLUMN OA_TEST_AUDIT.NEWA IS '调整后标准 薪酬档级';
COMMENT ON COLUMN OA_TEST_AUDIT.NEWB IS '调整后标准 月工资额';
COMMENT ON COLUMN OA_TEST_AUDIT.NEWC IS '调整后标准 年薪总额';
COMMENT ON COLUMN OA_TEST_AUDIT.ADD_NUM IS '月增资';
COMMENT ON COLUMN OA_TEST_AUDIT.EXE_DATE IS '执行时间';
COMMENT ON COLUMN OA_TEST_AUDIT.HR_TEXT IS '人力资源部门意见';
COMMENT ON COLUMN OA_TEST_AUDIT.LEAD_TEXT IS '分管领导意见';
COMMENT ON COLUMN OA_TEST_AUDIT.MAIN_LEAD_TEXT IS '集团主要领导意见';
COMMENT ON COLUMN OA_TEST_AUDIT.create_by IS '创建者';
COMMENT ON COLUMN OA_TEST_AUDIT.create_date IS '创建时间';
COMMENT ON COLUMN OA_TEST_AUDIT.update_by IS '更新者';
COMMENT ON COLUMN OA_TEST_AUDIT.update_date IS '更新时间';
COMMENT ON COLUMN OA_TEST_AUDIT.remarks IS '备注信息';
COMMENT ON COLUMN OA_TEST_AUDIT.del_flag IS '删除标记';

/*Data for the table `oa_test_audit` */

/*Table structure for table `sys_area` */

CREATE TABLE sys_area
(
	id varchar2(64) NOT NULL,
	parent_id varchar2(64) NOT NULL,
	parent_ids varchar2(2000) NOT NULL,
	name nvarchar2(100) NOT NULL,
	sort number(10,0) NOT NULL,
	code varchar2(100),
	type char(1),
	create_by varchar2(64) NOT NULL,
	create_date timestamp NOT NULL,
	update_by varchar2(64) NOT NULL,
	update_date timestamp NOT NULL,
	remarks nvarchar2(255),
	del_flag char(1) DEFAULT '0' NOT NULL,
	PRIMARY KEY (id)
);

/* 添加注释 */
comment on table sys_area is '区域表';
Comment on column sys_area.id is '编号';
Comment on column sys_area.parent_id is '父级编号';
Comment on column sys_area.parent_ids is '所有父级编号';
Comment on column sys_area.name is '名称';
Comment on column sys_area.sort is '排序';
Comment on column sys_area.code is '区域编码';
Comment on column sys_area.type is '区域类型';
Comment on column sys_area.create_by is '创建者';
Comment on column sys_area.create_date is '创建时间';
Comment on column sys_area.update_by is '更新者';
Comment on column sys_area.update_date is '更新时间';
Comment on column sys_area.remarks is '备注信息';
Comment on column sys_area.del_flag is '删除标记';


/*Data for the table `sys_area` */

insert  into sys_area(id,parent_id,parent_ids , name , sort , code , type , create_by , create_date , update_by , update_date , remarks , del_flag ) 
values ('1','0','0,','中国','10','100000','1','1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0');
insert  into sys_area(id,parent_id,parent_ids , name , sort , code , type , create_by , create_date , update_by , update_date , remarks , del_flag ) 
values ('2','1','0,1,','山东省','20','110000','2','1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0');
insert  into sys_area(id,parent_id,parent_ids , name , sort , code , type , create_by , create_date , update_by , update_date , remarks , del_flag ) 
values ('3','2','0,1,2,','济南市','30','110101','3','1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0');
insert  into sys_area(id,parent_id,parent_ids , name , sort , code , type , create_by , create_date , update_by , update_date , remarks , del_flag ) 
values ('4','3','0,1,2,3,','历城区','40','110102','4','1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0');
insert  into sys_area(id,parent_id,parent_ids , name , sort , code , type , create_by , create_date , update_by , update_date , remarks , del_flag ) 
values ('5','3','0,1,2,3,','历下区','50','110104','4','1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0');
insert  into sys_area(id,parent_id,parent_ids , name , sort , code , type , create_by , create_date , update_by , update_date , remarks , del_flag ) 
values ('6','3','0,1,2,3,','高新区','60','110105','4','1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0');

commit;

/*Table structure for table `sys_dict` */

-- 字典表
CREATE TABLE sys_dict
(
	id varchar2(64) NOT NULL,
	value varchar2(100) NOT NULL,
	label varchar2(100) NOT NULL,
	type varchar2(100) NOT NULL,
	description nvarchar2(100) NOT NULL,
	sort number(10,0) NOT NULL,
	parent_id varchar2(64) DEFAULT '0',
	create_by varchar2(64) NOT NULL,
	create_date timestamp NOT NULL,
	update_by varchar2(64) NOT NULL,
	update_date timestamp NOT NULL,
	remarks nvarchar2(255),
	del_flag char(1) DEFAULT '0' NOT NULL,
	PRIMARY KEY (id)
);

/* 添加注释 */
comment on table sys_dict is '字典表';
Comment on column sys_dict.id is '编号';
Comment on column sys_dict.value is '数据值';
Comment on column sys_dict.label is '标签名';
Comment on column sys_dict.type is '类型';
Comment on column sys_dict.description is '描述';
Comment on column sys_dict.sort is '排序（升序）';
Comment on column sys_dict.parent_id is '父级编号';
Comment on column sys_dict.create_by is '创建者';
Comment on column sys_dict.create_date is '创建时间';
Comment on column sys_dict.update_by is '更新者';
Comment on column sys_dict.update_date is '更新时间';
Comment on column sys_dict.remarks is '备注信息';
Comment on column sys_dict.del_flag is '删除标记';

/*Data for the table `sys_dict` */

insert into sys_dict(id,value,label,type,description,sort,parent_id,create_by,create_date,update_by,update_date,remarks,del_flag) 
values ('1','0','正常','del_flag','删除标记','10','0','1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0');
insert into sys_dict(id,value,label,type,description,sort,parent_id,create_by,create_date,update_by,update_date,remarks,del_flag) 
values ('10','yellow','黄色','color','颜色值','40','0','1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0');
insert into sys_dict(id,value,label,type,description,sort,parent_id,create_by,create_date,update_by,update_date,remarks,del_flag) 
values ('100','java.util.Date','Date','gen_java_type','Java类型\0\0','50','0','1',to_timestamp('2013-10-28 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1',to_timestamp('2013-10-28 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'1');
insert into sys_dict(id,value,label,type,description,sort,parent_id,create_by,create_date,update_by,update_date,remarks,del_flag) 
values ('101','com.krazy.kcfw.modules.sys.entity.User','User','gen_java_type','Java类型\0\0','60','0','1',to_timestamp('2013-10-28 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1',to_timestamp('2013-10-28 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'1');
insert into sys_dict(id,value,label,type,description,sort,parent_id,create_by,create_date,update_by,update_date,remarks,del_flag) 
values ('102','com.krazy.kcfw.modules.sys.entity.Office','Office','gen_java_type','Java类型\0\0','70','0','1',to_timestamp('2013-10-28 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1',to_timestamp('2013-10-28 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'1');
insert into sys_dict(id,value,label,type,description,sort,parent_id,create_by,create_date,update_by,update_date,remarks,del_flag) 
values ('103','com.krazy.kcfw.modules.sys.entity.Area','Area','gen_java_type','Java类型\0\0','80','0','1',to_timestamp('2013-10-28 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1',to_timestamp('2013-10-28 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'1');
insert into sys_dict(id,value,label,type,description,sort,parent_id,create_by,create_date,update_by,update_date,remarks,del_flag) 
values ('104','Custom','Custom','gen_java_type','Java类型\0\0','90','0','1',to_timestamp('2013-10-28 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1',to_timestamp('2013-10-28 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'1');
insert into sys_dict(id,value,label,type,description,sort,parent_id,create_by,create_date,update_by,update_date,remarks,del_flag) 
values ('105','1','会议通告\0\0\0\0','oa_notify_type','通知通告类型','10','0','1',to_timestamp('2013-11-08 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1',to_timestamp('2013-11-08 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0');
insert into sys_dict(id,value,label,type,description,sort,parent_id,create_by,create_date,update_by,update_date,remarks,del_flag) 
values ('106','2','奖惩通告\0\0\0\0','oa_notify_type','通知通告类型','20','0','1',to_timestamp('2013-11-08 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1',to_timestamp('2013-11-08 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0');
insert into sys_dict(id,value,label,type,description,sort,parent_id,create_by,create_date,update_by,update_date,remarks,del_flag) 
values ('107','3','活动通告\0\0\0\0','oa_notify_type','通知通告类型','30','0','1',to_timestamp('2013-11-08 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1',to_timestamp('2013-11-08 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0');
insert into sys_dict(id,value,label,type,description,sort,parent_id,create_by,create_date,update_by,update_date,remarks,del_flag) 
values ('108','0','草稿','oa_notify_status','通知通告状态','10','0','1',to_timestamp('2013-11-08 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1',to_timestamp('2013-11-08 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0');
insert into sys_dict(id,value,label,type,description,sort,parent_id,create_by,create_date,update_by,update_date,remarks,del_flag) 
values ('109','1','发布','oa_notify_status','通知通告状态','20','0','1',to_timestamp('2013-11-08 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1',to_timestamp('2013-11-08 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0');
insert into sys_dict(id,value,label,type,description,sort,parent_id,create_by,create_date,update_by,update_date,remarks,del_flag) 
values ('11','orange','橙色','color','颜色值','50','0','1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0');
insert into sys_dict(id,value,label,type,description,sort,parent_id,create_by,create_date,update_by,update_date,remarks,del_flag) 
values ('110','0','未读','oa_notify_read','通知通告状态','10','0','1',to_timestamp('2013-11-08 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1',to_timestamp('2013-11-08 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0');
insert into sys_dict(id,value,label,type,description,sort,parent_id,create_by,create_date,update_by,update_date,remarks,del_flag) 
values ('111','1','已读','oa_notify_read','通知通告状态','20','0','1',to_timestamp('2013-11-08 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1',to_timestamp('2013-11-08 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0');
insert into sys_dict(id,value,label,type,description,sort,parent_id,create_by,create_date,update_by,update_date,remarks,del_flag) 
values ('12','default','默认主题','theme','主题方案','10','0','1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0');
insert into sys_dict(id,value,label,type,description,sort,parent_id,create_by,create_date,update_by,update_date,remarks,del_flag) 
values ('13','cerulean','天蓝主题','theme','主题方案','20','0','1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0');
insert into sys_dict(id,value,label,type,description,sort,parent_id,create_by,create_date,update_by,update_date,remarks,del_flag) 
values ('14','readable','橙色主题','theme','主题方案','30','0','1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0');
insert into sys_dict(id,value,label,type,description,sort,parent_id,create_by,create_date,update_by,update_date,remarks,del_flag) 
values ('15','united','红色主题','theme','主题方案','40','0','1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0');
insert into sys_dict(id,value,label,type,description,sort,parent_id,create_by,create_date,update_by,update_date,remarks,del_flag) 
values ('16','flat','Flat主题','theme','主题方案','60','0','1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0');
insert into sys_dict(id,value,label,type,description,sort,parent_id,create_by,create_date,update_by,update_date,remarks,del_flag) 
values ('17','1','国家','sys_area_type','区域类型','10','0','1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0');
insert into sys_dict(id,value,label,type,description,sort,parent_id,create_by,create_date,update_by,update_date,remarks,del_flag) 
values ('18','2','省份、直辖市','sys_area_type','区域类型','20','0','1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0');
insert into sys_dict(id,value,label,type,description,sort,parent_id,create_by,create_date,update_by,update_date,remarks,del_flag) 
values ('19','3','地市','sys_area_type','区域类型','30','0','1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0');
insert into sys_dict(id,value,label,type,description,sort,parent_id,create_by,create_date,update_by,update_date,remarks,del_flag) 
values ('2','1','删除','del_flag','删除标记','20','0','1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0');
insert into sys_dict(id,value,label,type,description,sort,parent_id,create_by,create_date,update_by,update_date,remarks,del_flag) 
values ('20','4','区县','sys_area_type','区域类型','40','0','1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0');
insert into sys_dict(id,value,label,type,description,sort,parent_id,create_by,create_date,update_by,update_date,remarks,del_flag) 
values ('21','1','公司','sys_office_type','机构类型','60','0','1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0');
insert into sys_dict(id,value,label,type,description,sort,parent_id,create_by,create_date,update_by,update_date,remarks,del_flag) 
values ('22','2','部门','sys_office_type','机构类型','70','0','1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0');
insert into sys_dict(id,value,label,type,description,sort,parent_id,create_by,create_date,update_by,update_date,remarks,del_flag) 
values ('23','3','小组','sys_office_type','机构类型','80','0','1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0');
insert into sys_dict(id,value,label,type,description,sort,parent_id,create_by,create_date,update_by,update_date,remarks,del_flag) 
values ('24','4','其它','sys_office_type','机构类型','90','0','1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0');
insert into sys_dict(id,value,label,type,description,sort,parent_id,create_by,create_date,update_by,update_date,remarks,del_flag) 
values ('25','1','综合部','sys_office_common','快捷通用部门','30','0','1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0');
insert into sys_dict(id,value,label,type,description,sort,parent_id,create_by,create_date,update_by,update_date,remarks,del_flag) 
values ('26','2','开发部','sys_office_common','快捷通用部门','40','0','1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0');
insert into sys_dict(id,value,label,type,description,sort,parent_id,create_by,create_date,update_by,update_date,remarks,del_flag) 
values ('27','3','人力部','sys_office_common','快捷通用部门','50','0','1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0');
insert into sys_dict(id,value,label,type,description,sort,parent_id,create_by,create_date,update_by,update_date,remarks,del_flag) 
values ('28','1','一级','sys_office_grade','机构等级','10','0','1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0');
insert into sys_dict(id,value,label,type,description,sort,parent_id,create_by,create_date,update_by,update_date,remarks,del_flag) 
values ('29','2','二级','sys_office_grade','机构等级','20','0','1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0');
insert into sys_dict(id,value,label,type,description,sort,parent_id,create_by,create_date,update_by,update_date,remarks,del_flag) 
values ('3','1','显示','show_hide','显示/隐藏','10','0','1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0');
insert into sys_dict(id,value,label,type,description,sort,parent_id,create_by,create_date,update_by,update_date,remarks,del_flag) 
values ('30','3','三级','sys_office_grade','机构等级','30','0','1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0');
insert into sys_dict(id,value,label,type,description,sort,parent_id,create_by,create_date,update_by,update_date,remarks,del_flag) 
values ('31','4','四级','sys_office_grade','机构等级','40','0','1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0');
insert into sys_dict(id,value,label,type,description,sort,parent_id,create_by,create_date,update_by,update_date,remarks,del_flag) 
values ('32','1','所有数据','sys_data_scope','数据范围','10','0','1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0');
insert into sys_dict(id,value,label,type,description,sort,parent_id,create_by,create_date,update_by,update_date,remarks,del_flag) 
values ('33','2','所在公司及以下数据','sys_data_scope','数据范围','20','0','1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0');
insert into sys_dict(id,value,label,type,description,sort,parent_id,create_by,create_date,update_by,update_date,remarks,del_flag) 
values ('34','3','所在公司数据','sys_data_scope','数据范围','30','0','1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0');
insert into sys_dict(id,value,label,type,description,sort,parent_id,create_by,create_date,update_by,update_date,remarks,del_flag) 
values ('35','4','所在部门及以下数据','sys_data_scope','数据范围','40','0','1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0');
insert into sys_dict(id,value,label,type,description,sort,parent_id,create_by,create_date,update_by,update_date,remarks,del_flag) 
values ('36','5','所在部门数据','sys_data_scope','数据范围','50','0','1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0');
insert into sys_dict(id,value,label,type,description,sort,parent_id,create_by,create_date,update_by,update_date,remarks,del_flag) 
values ('37','8','仅本人数据','sys_data_scope','数据范围','90','0','1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0');
insert into sys_dict(id,value,label,type,description,sort,parent_id,create_by,create_date,update_by,update_date,remarks,del_flag) 
values ('38','9','按明细设置','sys_data_scope','数据范围','100','0','1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0');
insert into sys_dict(id,value,label,type,description,sort,parent_id,create_by,create_date,update_by,update_date,remarks,del_flag) 
values ('39','1','系统管理','sys_user_type','用户类型','10','0','1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0');
insert into sys_dict(id,value,label,type,description,sort,parent_id,create_by,create_date,update_by,update_date,remarks,del_flag) 
values ('4','0','隐藏','show_hide','显示/隐藏','20','0','1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0');
insert into sys_dict(id,value,label,type,description,sort,parent_id,create_by,create_date,update_by,update_date,remarks,del_flag) 
values ('40','2','部门经理','sys_user_type','用户类型','20','0','1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0');
insert into sys_dict(id,value,label,type,description,sort,parent_id,create_by,create_date,update_by,update_date,remarks,del_flag) 
values ('41','3','普通用户','sys_user_type','用户类型','30','0','1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0');
insert into sys_dict(id,value,label,type,description,sort,parent_id,create_by,create_date,update_by,update_date,remarks,del_flag) 
values ('42','basic','基础主题','cms_theme','站点主题','10','0','1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0');
insert into sys_dict(id,value,label,type,description,sort,parent_id,create_by,create_date,update_by,update_date,remarks,del_flag) 
values ('43','blue','蓝色主题','cms_theme','站点主题','20','0','1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'1');
insert into sys_dict(id,value,label,type,description,sort,parent_id,create_by,create_date,update_by,update_date,remarks,del_flag) 
values ('44','red','红色主题','cms_theme','站点主题','30','0','1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'1');
insert into sys_dict(id,value,label,type,description,sort,parent_id,create_by,create_date,update_by,update_date,remarks,del_flag) 
values ('45','article','文章模型','cms_module','栏目模型','10','0','1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0');
insert into sys_dict(id,value,label,type,description,sort,parent_id,create_by,create_date,update_by,update_date,remarks,del_flag) 
values ('46','picture','图片模型','cms_module','栏目模型','20','0','1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'1');
insert into sys_dict(id,value,label,type,description,sort,parent_id,create_by,create_date,update_by,update_date,remarks,del_flag) 
values ('47','download','下载模型','cms_module','栏目模型','30','0','1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'1');
insert into sys_dict(id,value,label,type,description,sort,parent_id,create_by,create_date,update_by,update_date,remarks,del_flag) 
values ('48','link','链接模型','cms_module','栏目模型','40','0','1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0');
insert into sys_dict(id,value,label,type,description,sort,parent_id,create_by,create_date,update_by,update_date,remarks,del_flag) 
values ('49','special','专题模型','cms_module','栏目模型','50','0','1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'1');
insert into sys_dict(id,value,label,type,description,sort,parent_id,create_by,create_date,update_by,update_date,remarks,del_flag) 
values ('5','1','是','yes_no','是/否','10','0','1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0');
insert into sys_dict(id,value,label,type,description,sort,parent_id,create_by,create_date,update_by,update_date,remarks,del_flag) 
values ('50','0','默认展现方式','cms_show_modes','展现方式','10','0','1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0');
insert into sys_dict(id,value,label,type,description,sort,parent_id,create_by,create_date,update_by,update_date,remarks,del_flag) 
values ('51','1','首栏目内容列表','cms_show_modes','展现方式','20','0','1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0');
insert into sys_dict(id,value,label,type,description,sort,parent_id,create_by,create_date,update_by,update_date,remarks,del_flag) 
values ('52','2','栏目第一条内容','cms_show_modes','展现方式','30','0','1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0');
insert into sys_dict(id,value,label,type,description,sort,parent_id,create_by,create_date,update_by,update_date,remarks,del_flag) 
values ('53','0','发布','cms_del_flag','内容状态','10','0','1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0');
insert into sys_dict(id,value,label,type,description,sort,parent_id,create_by,create_date,update_by,update_date,remarks,del_flag) 
values ('54','1','删除','cms_del_flag','内容状态','20','0','1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0');
insert into sys_dict(id,value,label,type,description,sort,parent_id,create_by,create_date,update_by,update_date,remarks,del_flag) 
values ('55','2','审核','cms_del_flag','内容状态','15','0','1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0');
insert into sys_dict(id,value,label,type,description,sort,parent_id,create_by,create_date,update_by,update_date,remarks,del_flag) 
values ('56','1','首页焦点图','cms_posid','推荐位','10','0','1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0');
insert into sys_dict(id,value,label,type,description,sort,parent_id,create_by,create_date,update_by,update_date,remarks,del_flag) 
values ('57','2','栏目页文章推荐','cms_posid','推荐位','20','0','1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0');
insert into sys_dict(id,value,label,type,description,sort,parent_id,create_by,create_date,update_by,update_date,remarks,del_flag) 
values ('58','1','咨询','cms_guestbook','留言板分类','10','0','1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0');
insert into sys_dict(id,value,label,type,description,sort,parent_id,create_by,create_date,update_by,update_date,remarks,del_flag) 
values ('59','2','建议','cms_guestbook','留言板分类','20','0','1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0');
insert into sys_dict(id,value,label,type,description,sort,parent_id,create_by,create_date,update_by,update_date,remarks,del_flag) 
values ('6','0','否','yes_no','是/否','20','0','1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0');
insert into sys_dict(id,value,label,type,description,sort,parent_id,create_by,create_date,update_by,update_date,remarks,del_flag) 
values ('60','3','投诉','cms_guestbook','留言板分类','30','0','1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0');
insert into sys_dict(id,value,label,type,description,sort,parent_id,create_by,create_date,update_by,update_date,remarks,del_flag) 
values ('61','4','其它','cms_guestbook','留言板分类','40','0','1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0');
insert into sys_dict(id,value,label,type,description,sort,parent_id,create_by,create_date,update_by,update_date,remarks,del_flag) 
values ('62','1','公休','oa_leave_type','请假类型','10','0','1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0');
insert into sys_dict(id,value,label,type,description,sort,parent_id,create_by,create_date,update_by,update_date,remarks,del_flag) 
values ('63','2','病假','oa_leave_type','请假类型','20','0','1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0');
insert into sys_dict(id,value,label,type,description,sort,parent_id,create_by,create_date,update_by,update_date,remarks,del_flag) 
values ('64','3','事假','oa_leave_type','请假类型','30','0','1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0');
insert into sys_dict(id,value,label,type,description,sort,parent_id,create_by,create_date,update_by,update_date,remarks,del_flag) 
values ('65','4','调休','oa_leave_type','请假类型','40','0','1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0');
insert into sys_dict(id,value,label,type,description,sort,parent_id,create_by,create_date,update_by,update_date,remarks,del_flag) 
values ('66','5','婚假','oa_leave_type','请假类型','60','0','1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0');
insert into sys_dict(id,value,label,type,description,sort,parent_id,create_by,create_date,update_by,update_date,remarks,del_flag) 
values ('67','1','接入日志','sys_log_type','日志类型','30','0','1',to_timestamp('2013-06-03 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1',to_timestamp('2013-06-03 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0');
insert into sys_dict(id,value,label,type,description,sort,parent_id,create_by,create_date,update_by,update_date,remarks,del_flag) 
values ('68','2','异常日志','sys_log_type','日志类型','40','0','1',to_timestamp('2013-06-03 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1',to_timestamp('2013-06-03 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0');
insert into sys_dict(id,value,label,type,description,sort,parent_id,create_by,create_date,update_by,update_date,remarks,del_flag) 
values ('69','leave','请假流程','act_type','流程类型','10','0','1',to_timestamp('2013-06-03 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1',to_timestamp('2013-06-03 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0');
insert into sys_dict(id,value,label,type,description,sort,parent_id,create_by,create_date,update_by,update_date,remarks,del_flag) 
values ('7','red','红色','color','颜色值','10','0','1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0');
insert into sys_dict(id,value,label,type,description,sort,parent_id,create_by,create_date,update_by,update_date,remarks,del_flag) 
values ('70','test_audit','审批测试流程','act_type','流程类型','20','0','1',to_timestamp('2013-06-03 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1',to_timestamp('2013-06-03 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0');
insert into sys_dict(id,value,label,type,description,sort,parent_id,create_by,create_date,update_by,update_date,remarks,del_flag) 
values ('71','1','分类1','act_category','流程分类','10','0','1',to_timestamp('2013-06-03 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1',to_timestamp('2013-06-03 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0');
insert into sys_dict(id,value,label,type,description,sort,parent_id,create_by,create_date,update_by,update_date,remarks,del_flag) 
values ('72','2','分类2','act_category','流程分类','20','0','1',to_timestamp('2013-06-03 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1',to_timestamp('2013-06-03 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0');
insert into sys_dict(id,value,label,type,description,sort,parent_id,create_by,create_date,update_by,update_date,remarks,del_flag) 
values ('73','crud','增删改查','gen_category','代码生成分类','10','0','1',to_timestamp('2013-10-28 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1',to_timestamp('2013-10-28 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'1');
insert into sys_dict(id,value,label,type,description,sort,parent_id,create_by,create_date,update_by,update_date,remarks,del_flag) 
values ('74','crud_many','增删改查（包含从表）','gen_category','代码生成分类','20','0','1',to_timestamp('2013-10-28 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1',to_timestamp('2013-10-28 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'1');
insert into sys_dict(id,value,label,type,description,sort,parent_id,create_by,create_date,update_by,update_date,remarks,del_flag) 
values ('75','tree','树结构','gen_category','代码生成分类','30','0','1',to_timestamp('2013-10-28 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1',to_timestamp('2013-10-28 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'1');
insert into sys_dict(id,value,label,type,description,sort,parent_id,create_by,create_date,update_by,update_date,remarks,del_flag) 
values ('76','=','=','gen_query_type','查询方式','10','0','1',to_timestamp('2013-10-28 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1',to_timestamp('2013-10-28 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'1');
insert into sys_dict(id,value,label,type,description,sort,parent_id,create_by,create_date,update_by,update_date,remarks,del_flag) 
values ('77','!=','!=','gen_query_type','查询方式','20','0','1',to_timestamp('2013-10-28 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1',to_timestamp('2013-10-28 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'1');
insert into sys_dict(id,value,label,type,description,sort,parent_id,create_by,create_date,update_by,update_date,remarks,del_flag) 
values ('78','&gt;','&gt;','gen_query_type','查询方式','30','0','1',to_timestamp('2013-10-28 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1',to_timestamp('2013-10-28 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'1');
insert into sys_dict(id,value,label,type,description,sort,parent_id,create_by,create_date,update_by,update_date,remarks,del_flag) 
values ('79','&lt;','&lt;','gen_query_type','查询方式','40','0','1',to_timestamp('2013-10-28 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1',to_timestamp('2013-10-28 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'1');
insert into sys_dict(id,value,label,type,description,sort,parent_id,create_by,create_date,update_by,update_date,remarks,del_flag) 
values ('8','green','绿色','color','颜色值','20','0','1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0');
insert into sys_dict(id,value,label,type,description,sort,parent_id,create_by,create_date,update_by,update_date,remarks,del_flag) 
values ('80','between','Between','gen_query_type','查询方式','50','0','1',to_timestamp('2013-10-28 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1',to_timestamp('2013-10-28 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'1');
insert into sys_dict(id,value,label,type,description,sort,parent_id,create_by,create_date,update_by,update_date,remarks,del_flag) 
values ('81','like','Like','gen_query_type','查询方式','60','0','1',to_timestamp('2013-10-28 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1',to_timestamp('2013-10-28 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'1');
insert into sys_dict(id,value,label,type,description,sort,parent_id,create_by,create_date,update_by,update_date,remarks,del_flag) 
values ('82','left_like','Left Like','gen_query_type','查询方式','70','0','1',to_timestamp('2013-10-28 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1',to_timestamp('2013-10-28 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'1');
insert into sys_dict(id,value,label,type,description,sort,parent_id,create_by,create_date,update_by,update_date,remarks,del_flag) 
values ('83','right_like','Right Like','gen_query_type','查询方式','80','0','1',to_timestamp('2013-10-28 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1',to_timestamp('2013-10-28 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'1');
insert into sys_dict(id,value,label,type,description,sort,parent_id,create_by,create_date,update_by,update_date,remarks,del_flag) 
values ('84','input','文本框','gen_show_type','字段生成方案','10','0','1',to_timestamp('2013-10-28 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1',to_timestamp('2013-10-28 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'1');
insert into sys_dict(id,value,label,type,description,sort,parent_id,create_by,create_date,update_by,update_date,remarks,del_flag) 
values ('85','textarea','文本域','gen_show_type','字段生成方案','20','0','1',to_timestamp('2013-10-28 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1',to_timestamp('2013-10-28 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'1');
insert into sys_dict(id,value,label,type,description,sort,parent_id,create_by,create_date,update_by,update_date,remarks,del_flag) 
values ('86','select','下拉框','gen_show_type','字段生成方案','30','0','1',to_timestamp('2013-10-28 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1',to_timestamp('2013-10-28 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'1');
insert into sys_dict(id,value,label,type,description,sort,parent_id,create_by,create_date,update_by,update_date,remarks,del_flag) 
values ('87','checkbox','复选框','gen_show_type','字段生成方案','40','0','1',to_timestamp('2013-10-28 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1',to_timestamp('2013-10-28 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'1');
insert into sys_dict(id,value,label,type,description,sort,parent_id,create_by,create_date,update_by,update_date,remarks,del_flag) 
values ('88','radiobox','单选框','gen_show_type','字段生成方案','50','0','1',to_timestamp('2013-10-28 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1',to_timestamp('2013-10-28 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'1');
insert into sys_dict(id,value,label,type,description,sort,parent_id,create_by,create_date,update_by,update_date,remarks,del_flag) 
values ('89','dateselect','日期选择','gen_show_type','字段生成方案','60','0','1',to_timestamp('2013-10-28 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1',to_timestamp('2013-10-28 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'1');
insert into sys_dict(id,value,label,type,description,sort,parent_id,create_by,create_date,update_by,update_date,remarks,del_flag) 
values ('9','blue','蓝色','color','颜色值','30','0','1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0');
insert into sys_dict(id,value,label,type,description,sort,parent_id,create_by,create_date,update_by,update_date,remarks,del_flag) 
values ('90','userselect','人员选择\0','gen_show_type','字段生成方案','70','0','1',to_timestamp('2013-10-28 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1',to_timestamp('2013-10-28 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'1');
insert into sys_dict(id,value,label,type,description,sort,parent_id,create_by,create_date,update_by,update_date,remarks,del_flag) 
values ('91','officeselect','部门选择','gen_show_type','字段生成方案','80','0','1',to_timestamp('2013-10-28 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1',to_timestamp('2013-10-28 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'1');
insert into sys_dict(id,value,label,type,description,sort,parent_id,create_by,create_date,update_by,update_date,remarks,del_flag) 
values ('92','areaselect','区域选择','gen_show_type','字段生成方案','90','0','1',to_timestamp('2013-10-28 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1',to_timestamp('2013-10-28 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'1');
insert into sys_dict(id,value,label,type,description,sort,parent_id,create_by,create_date,update_by,update_date,remarks,del_flag) 
values ('93','String','String','gen_java_type','Java类型','10','0','1',to_timestamp('2013-10-28 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1',to_timestamp('2013-10-28 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'1');
insert into sys_dict(id,value,label,type,description,sort,parent_id,create_by,create_date,update_by,update_date,remarks,del_flag) 
values ('94','Long','Long','gen_java_type','Java类型','20','0','1',to_timestamp('2013-10-28 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1',to_timestamp('2013-10-28 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'1');
insert into sys_dict(id,value,label,type,description,sort,parent_id,create_by,create_date,update_by,update_date,remarks,del_flag) 
values ('95','dao','仅持久层','gen_category','代码生成分类\0\0\0\0\0\0','40','0','1',to_timestamp('2013-10-28 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1',to_timestamp('2013-10-28 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'1');
insert into sys_dict(id,value,label,type,description,sort,parent_id,create_by,create_date,update_by,update_date,remarks,del_flag) 
values ('96','1','男','sex','性别','10','0','1',to_timestamp('2013-10-28 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1',to_timestamp('2013-10-28 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0');
insert into sys_dict(id,value,label,type,description,sort,parent_id,create_by,create_date,update_by,update_date,remarks,del_flag) 
values ('97','2','女','sex','性别','20','0','1',to_timestamp('2013-10-28 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1',to_timestamp('2013-10-28 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0');
insert into sys_dict(id,value,label,type,description,sort,parent_id,create_by,create_date,update_by,update_date,remarks,del_flag) 
values ('98','Integer','Integer','gen_java_type','Java类型\0\0','30','0','1',to_timestamp('2013-10-28 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1',to_timestamp('2013-10-28 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'1');
insert into sys_dict(id,value,label,type,description,sort,parent_id,create_by,create_date,update_by,update_date,remarks,del_flag) 
values ('99','Double','Double','gen_java_type','Java类型\0\0','40','0','1',to_timestamp('2013-10-28 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1',to_timestamp('2013-10-28 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'1');

commit;
/*Table structure for table `sys_log` */

-- 日志表
CREATE TABLE sys_log
(
	id varchar2(64) NOT NULL,
	type char(1) DEFAULT '1',
	title nvarchar2(500),
	create_by varchar2(64),
	create_date timestamp,
	remote_addr varchar2(255),
	user_agent varchar2(255),
	request_uri varchar2(255),
	method varchar2(5),
	params clob,
	exception clob,
	PRIMARY KEY (id)
);

/* 添加注释 */
comment on table sys_log is '日志表';
Comment on column sys_log.id is '编号';
Comment on column sys_log.type is '日志类型';
Comment on column sys_log.title is '日志标题';
Comment on column sys_log.create_by is '创建者';
Comment on column sys_log.create_date is '创建时间';
Comment on column sys_log.remote_addr is '操作IP地址';
Comment on column sys_log.user_agent is '用户代理';
Comment on column sys_log.request_uri is '请求URI';
Comment on column sys_log.method is '操作方式';
Comment on column sys_log.params is '操作提交的数据';
Comment on column sys_log.exception is '异常信息';


/*Data for the table `sys_log` */

/*Table structure for table `sys_mdict` */

-- 多级字典表
CREATE TABLE sys_mdict
(
	id varchar2(64) NOT NULL,
	parent_id varchar2(64) NOT NULL,
	parent_ids varchar2(2000) NOT NULL,
	name nvarchar2(100) NOT NULL,
	sort number(10,0) NOT NULL,
	description nvarchar2(100),
	create_by varchar2(64) NOT NULL,
	create_date timestamp NOT NULL,
	update_by varchar2(64) NOT NULL,
	update_date timestamp NOT NULL,
	remarks nvarchar2(255),
	del_flag char(1) DEFAULT '0' NOT NULL,
	PRIMARY KEY (id)
);

/* 添加注释 */
comment on table sys_mdict is '多级字典表';
Comment on column sys_mdict.id is '编号';
Comment on column sys_mdict.parent_id is '父级编号';
Comment on column sys_mdict.parent_ids is '所有父级编号';
Comment on column sys_mdict.name is '名称';
Comment on column sys_mdict.sort is '排序';
Comment on column sys_mdict.description is '描述';
Comment on column sys_mdict.create_by is '创建者';
Comment on column sys_mdict.create_date is '创建时间';
Comment on column sys_mdict.update_by is '更新者';
Comment on column sys_mdict.update_date is '更新时间';
Comment on column sys_mdict.remarks is '备注信息';
Comment on column sys_mdict.del_flag is '删除标记';

/*Data for the table `sys_mdict` */

/*Table structure for table `sys_menu` */

-- 菜单表
CREATE TABLE sys_menu
(
	id varchar2(64) NOT NULL,
	parent_id varchar2(64) NOT NULL,
	parent_ids varchar2(2000) NOT NULL,
	name nvarchar2(100) NOT NULL,
	sort number(10,0) NOT NULL,
	href varchar2(2000),
	target varchar2(20),
	icon varchar2(100),
	is_show char(1) NOT NULL,
	permission varchar2(200),
	create_by varchar2(64) NOT NULL,
	create_date timestamp NOT NULL,
	update_by varchar2(64) NOT NULL,
	update_date timestamp NOT NULL,
	remarks nvarchar2(255),
	del_flag char(1) DEFAULT '0' NOT NULL,
	PRIMARY KEY (id)
);

/* 添加注释 */
comment on table sys_menu is '菜单表';
Comment on column sys_menu.id is '编号';
Comment on column sys_menu.parent_id is '父级编号';
Comment on column sys_menu.parent_ids is '所有父级编号';
Comment on column sys_menu.name is '名称';
Comment on column sys_menu.sort is '排序';
Comment on column sys_menu.href is '链接';
Comment on column sys_menu.target is '目标';
Comment on column sys_menu.icon is '图标';
Comment on column sys_menu.is_show is '是否在菜单中显示';
Comment on column sys_menu.permission is '权限标识';
Comment on column sys_menu.create_by is '创建者';
Comment on column sys_menu.create_date is '创建时间';
Comment on column sys_menu.update_by is '更新者';
Comment on column sys_menu.update_date is '更新时间';
Comment on column sys_menu.remarks is '备注信息';
Comment on column sys_menu.del_flag is '删除标记';


/*Data for the table `sys_menu` */

insert  into sys_menu(id,parent_id,parent_ids,name,sort,href,target,icon,is_show,permission,create_by,create_date,update_by,update_date,remarks,del_flag) values ('0b2ebd4d639e4c2b83c2dd0764522f24','ba8092291b40482db8fe7fc006ea3d76','0,1,79,3c92c17886944d0687e73e286cada573,ba8092291b40482db8fe7fc006ea3d76,','编辑','60','','','','0','test:testData:edit','1',to_timestamp('2013-08-12 13:10:05','yyyy-mm-dd hh24:mi:ss.ff'),'1',to_timestamp('2013-08-12 13:10:05','yyyy-mm-dd hh24:mi:ss.ff'),'','0'); 
insert  into sys_menu(id,parent_id,parent_ids,name,sort,href,target,icon,is_show,permission,create_by,create_date,update_by,update_date,remarks,del_flag) values ('0ca004d6b1bf4bcab9670a5060d82a55','3c92c17886944d0687e73e286cada573','0,1,79,3c92c17886944d0687e73e286cada573,','树结构','90','/test/testTree','','','1','','1',to_timestamp('2013-08-12 13:10:05','yyyy-mm-dd hh24:mi:ss.ff'),'1',to_timestamp('2013-08-12 13:10:05','yyyy-mm-dd hh24:mi:ss.ff'),'','0'); 
insert  into sys_menu(id,parent_id,parent_ids,name,sort,href,target,icon,is_show,permission,create_by,create_date,update_by,update_date,remarks,del_flag) values ('1','0','0,','功能菜单','0',NULL,NULL,NULL,'1',NULL,'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0'); 
insert  into sys_menu(id,parent_id,parent_ids,name,sort,href,target,icon,is_show,permission,create_by,create_date,update_by,update_date,remarks,del_flag) values ('10','3','0,1,2,3,','字典管理','60','/sys/dict/',NULL,'th-list','1',NULL,'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0'); 
insert  into sys_menu(id,parent_id,parent_ids,name,sort,href,target,icon,is_show,permission,create_by,create_date,update_by,update_date,remarks,del_flag) values ('11','10','0,1,2,3,10,','查看','30',NULL,NULL,NULL,'0','sys:dict:view','1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0'); 
insert  into sys_menu(id,parent_id,parent_ids,name,sort,href,target,icon,is_show,permission,create_by,create_date,update_by,update_date,remarks,del_flag) values ('12','10','0,1,2,3,10,','修改','40',NULL,NULL,NULL,'0','sys:dict:edit','1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0'); 
insert  into sys_menu(id,parent_id,parent_ids,name,sort,href,target,icon,is_show,permission,create_by,create_date,update_by,update_date,remarks,del_flag) values ('13','2','0,1,2,','机构用户','970',NULL,NULL,NULL,'1',NULL,'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0'); 
insert  into sys_menu(id,parent_id,parent_ids,name,sort,href,target,icon,is_show,permission,create_by,create_date,update_by,update_date,remarks,del_flag) values ('14','13','0,1,2,13,','区域管理','50','/sys/area/',NULL,'th','1',NULL,'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0'); 
insert  into sys_menu(id,parent_id,parent_ids,name,sort,href,target,icon,is_show,permission,create_by,create_date,update_by,update_date,remarks,del_flag) values ('15','14','0,1,2,13,14,','查看','30',NULL,NULL,NULL,'0','sys:area:view','1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0'); 
insert  into sys_menu(id,parent_id,parent_ids,name,sort,href,target,icon,is_show,permission,create_by,create_date,update_by,update_date,remarks,del_flag) values ('16','14','0,1,2,13,14,','修改','40',NULL,NULL,NULL,'0','sys:area:edit','1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0'); 
insert  into sys_menu(id,parent_id,parent_ids,name,sort,href,target,icon,is_show,permission,create_by,create_date,update_by,update_date,remarks,del_flag) values ('17','13','0,1,2,13,','机构管理','40','/sys/office/',NULL,'th-large','1',NULL,'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0'); 
insert  into sys_menu(id,parent_id,parent_ids,name,sort,href,target,icon,is_show,permission,create_by,create_date,update_by,update_date,remarks,del_flag) values ('18','17','0,1,2,13,17,','查看','30',NULL,NULL,NULL,'0','sys:office:view','1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0'); 
insert  into sys_menu(id,parent_id,parent_ids,name,sort,href,target,icon,is_show,permission,create_by,create_date,update_by,update_date,remarks,del_flag) values ('19','17','0,1,2,13,17,','修改','40',NULL,NULL,NULL,'0','sys:office:edit','1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0'); 
insert  into sys_menu(id,parent_id,parent_ids,name,sort,href,target,icon,is_show,permission,create_by,create_date,update_by,update_date,remarks,del_flag) values ('2','1','0,1,','系统设置','900',NULL,NULL,NULL,'1',NULL,'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0'); 
insert  into sys_menu(id,parent_id,parent_ids,name,sort,href,target,icon,is_show,permission,create_by,create_date,update_by,update_date,remarks,del_flag) values ('20','13','0,1,2,13,','用户管理','30','/sys/user/index',NULL,'user','1',NULL,'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0'); 
insert  into sys_menu(id,parent_id,parent_ids,name,sort,href,target,icon,is_show,permission,create_by,create_date,update_by,update_date,remarks,del_flag) values ('21','20','0,1,2,13,20,','查看','30',NULL,NULL,NULL,'0','sys:user:view','1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0'); 
insert  into sys_menu(id,parent_id,parent_ids,name,sort,href,target,icon,is_show,permission,create_by,create_date,update_by,update_date,remarks,del_flag) values ('22','20','0,1,2,13,20,','修改','40',NULL,NULL,NULL,'0','sys:user:edit','1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0'); 
insert  into sys_menu(id,parent_id,parent_ids,name,sort,href,target,icon,is_show,permission,create_by,create_date,update_by,update_date,remarks,del_flag) values ('23','2','0,1,2,','关于帮助','990',NULL,NULL,NULL,'0',NULL,'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0'); 
insert  into sys_menu(id,parent_id,parent_ids,name,sort,href,target,icon,is_show,permission,create_by,create_date,update_by,update_date,remarks,del_flag) values ('24','23','0,1,2,23','官方首页','30','http://kcfw.com','_blank',NULL,'0',NULL,'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0'); 
insert  into sys_menu(id,parent_id,parent_ids,name,sort,href,target,icon,is_show,permission,create_by,create_date,update_by,update_date,remarks,del_flag) values ('25','23','0,1,2,23','项目支持','50','http://kcfw.com/donation.html','_blank',NULL,'0',NULL,'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'1'); 
insert  into sys_menu(id,parent_id,parent_ids,name,sort,href,target,icon,is_show,permission,create_by,create_date,update_by,update_date,remarks,del_flag) values ('26','23','0,1,2,23','论坛交流','80','http://bbs.kcfw.com','_blank',NULL,'0',NULL,'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'1'); 
insert  into sys_menu(id,parent_id,parent_ids,name,sort,href,target,icon,is_show,permission,create_by,create_date,update_by,update_date,remarks,del_flag) values ('27','1','0,1,','我的面板','100',NULL,NULL,NULL,'1',NULL,'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0'); 
insert  into sys_menu(id,parent_id,parent_ids,name,sort,href,target,icon,is_show,permission,create_by,create_date,update_by,update_date,remarks,del_flag) values ('28','27','0,1,27,','个人信息','30',NULL,NULL,NULL,'1',NULL,'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0'); 
insert  into sys_menu(id,parent_id,parent_ids,name,sort,href,target,icon,is_show,permission,create_by,create_date,update_by,update_date,remarks,del_flag) values ('29','28','0,1,27,28,','个人信息','30','/sys/user/info',NULL,'user','1',NULL,'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0'); 
insert  into sys_menu(id,parent_id,parent_ids,name,sort,href,target,icon,is_show,permission,create_by,create_date,update_by,update_date,remarks,del_flag) values ('3','2','0,1,2,','系统设置','980',NULL,NULL,NULL,'1',NULL,'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0'); 
insert  into sys_menu(id,parent_id,parent_ids,name,sort,href,target,icon,is_show,permission,create_by,create_date,update_by,update_date,remarks,del_flag) values ('30','28','0,1,27,28,','修改密码','40','/sys/user/modifyPwd',NULL,'lock','1',NULL,'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0'); 
insert  into sys_menu(id,parent_id,parent_ids,name,sort,href,target,icon,is_show,permission,create_by,create_date,update_by,update_date,remarks,del_flag) values ('31','1','0,1,','内容管理','500',NULL,NULL,NULL,'1',NULL,'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0'); 
insert  into sys_menu(id,parent_id,parent_ids,name,sort,href,target,icon,is_show,permission,create_by,create_date,update_by,update_date,remarks,del_flag) values ('32','31','0,1,31,','栏目设置','990',NULL,NULL,NULL,'1',NULL,'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0'); 
insert  into sys_menu(id,parent_id,parent_ids,name,sort,href,target,icon,is_show,permission,create_by,create_date,update_by,update_date,remarks,del_flag) values ('33','32','0,1,31,32','栏目管理','30','/cms/category/',NULL,'align-justify','1',NULL,'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0'); 
insert  into sys_menu(id,parent_id,parent_ids,name,sort,href,target,icon,is_show,permission,create_by,create_date,update_by,update_date,remarks,del_flag) values ('34','33','0,1,31,32,33,','查看','30',NULL,NULL,NULL,'0','cms:category:view','1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0'); 
insert  into sys_menu(id,parent_id,parent_ids,name,sort,href,target,icon,is_show,permission,create_by,create_date,update_by,update_date,remarks,del_flag) values ('35','33','0,1,31,32,33,','修改','40',NULL,NULL,NULL,'0','cms:category:edit','1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0');
insert  into sys_menu(id,parent_id,parent_ids,name,sort,href,target,icon,is_show,permission,create_by,create_date,update_by,update_date,remarks,del_flag) values ('36','32','0,1,31,32','站点设置','40','/cms/site/',NULL,'certificate','1',NULL,'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0');
insert  into sys_menu(id,parent_id,parent_ids,name,sort,href,target,icon,is_show,permission,create_by,create_date,update_by,update_date,remarks,del_flag) values ('37','36','0,1,31,32,36,','查看','30',NULL,NULL,NULL,'0','cms:site:view','1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0'); 
insert  into sys_menu(id,parent_id,parent_ids,name,sort,href,target,icon,is_show,permission,create_by,create_date,update_by,update_date,remarks,del_flag) values ('38','36','0,1,31,32,36,','修改','40',NULL,NULL,NULL,'0','cms:site:edit','1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0'); 
insert  into sys_menu(id,parent_id,parent_ids,name,sort,href,target,icon,is_show,permission,create_by,create_date,update_by,update_date,remarks,del_flag) values ('39','32','0,1,31,32','切换站点','50','/cms/site/select',NULL,'retweet','1','cms:site:select','1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0'); 
insert  into sys_menu(id,parent_id,parent_ids,name,sort,href,target,icon,is_show,permission,create_by,create_date,update_by,update_date,remarks,del_flag) values ('3c92c17886944d0687e73e286cada573','79','0,1,79,','生成示例','120','','','','1','','1',to_timestamp('2013-08-12 13:10:05','yyyy-mm-dd hh24:mi:ss.ff'),'1',to_timestamp('2013-08-12 13:10:05','yyyy-mm-dd hh24:mi:ss.ff'),'','0'); 
 insert  into sys_menu(id,parent_id,parent_ids,name,sort,href,target,icon,is_show,permission,create_by,create_date,update_by,update_date,remarks,del_flag) values ('4','3','0,1,2,3,','菜单管理','30','/sys/menu/',NULL,'list-alt','1',NULL,'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0'); 
 insert  into sys_menu(id,parent_id,parent_ids,name,sort,href,target,icon,is_show,permission,create_by,create_date,update_by,update_date,remarks,del_flag) values ('40','31','0,1,31,','内容管理','500',NULL,NULL,NULL,'1','cms:view','1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0'); 
 insert  into sys_menu(id,parent_id,parent_ids,name,sort,href,target,icon,is_show,permission,create_by,create_date,update_by,update_date,remarks,del_flag) values ('41','40','0,1,31,40,','内容发布','30','/cms/',NULL,'briefcase','1',NULL,'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0'); 
 insert  into sys_menu(id,parent_id,parent_ids,name,sort,href,target,icon,is_show,permission,create_by,create_date,update_by,update_date,remarks,del_flag) values ('42','41','0,1,31,40,41,','文章模型','40','/cms/article/',NULL,'file','0',NULL,'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0'); 
 insert  into sys_menu(id,parent_id,parent_ids,name,sort,href,target,icon,is_show,permission,create_by,create_date,update_by,update_date,remarks,del_flag) values ('43','42','0,1,31,40,41,42,','查看','30',NULL,NULL,NULL,'0','cms:article:view','1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0'); 
 insert  into sys_menu(id,parent_id,parent_ids,name,sort,href,target,icon,is_show,permission,create_by,create_date,update_by,update_date,remarks,del_flag) values ('44','42','0,1,31,40,41,42,','修改','40',NULL,NULL,NULL,'0','cms:article:edit','1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0'); 
 insert  into sys_menu(id,parent_id,parent_ids,name,sort,href,target,icon,is_show,permission,create_by,create_date,update_by,update_date,remarks,del_flag) values ('45','42','0,1,31,40,41,42,','审核','50',NULL,NULL,NULL,'0','cms:article:audit','1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0'); 
 insert  into sys_menu(id,parent_id,parent_ids,name,sort,href,target,icon,is_show,permission,create_by,create_date,update_by,update_date,remarks,del_flag) values ('46','41','0,1,31,40,41,','链接模型','60','/cms/link/',NULL,'random','0',NULL,'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0');
 insert  into sys_menu(id,parent_id,parent_ids,name,sort,href,target,icon,is_show,permission,create_by,create_date,update_by,update_date,remarks,del_flag) values ('47','46','0,1,31,40,41,46,','查看','30',NULL,NULL,NULL,'0','cms:link:view','1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0'); 
 insert  into sys_menu(id,parent_id,parent_ids,name,sort,href,target,icon,is_show,permission,create_by,create_date,update_by,update_date,remarks,del_flag) values ('48','46','0,1,31,40,41,46,','修改','40',NULL,NULL,NULL,'0','cms:link:edit','1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0'); 
 insert  into sys_menu(id,parent_id,parent_ids,name,sort,href,target,icon,is_show,permission,create_by,create_date,update_by,update_date,remarks,del_flag) values ('4855cf3b25c244fb8500a380db189d97','b1f6d1b86ba24365bae7fd86c5082317','0,1,79,3c92c17886944d0687e73e286cada573,b1f6d1b86ba24365bae7fd86c5082317,','查看','30','','','','0','test:testDataMain:view','1',to_timestamp('2013-08-12 13:10:05','yyyy-mm-dd hh24:mi:ss.ff'),'1',to_timestamp('2013-08-12 13:10:05','yyyy-mm-dd hh24:mi:ss.ff'),'','0'); 
 insert  into sys_menu(id,parent_id,parent_ids,name,sort,href,target,icon,is_show,permission,create_by,create_date,update_by,update_date,remarks,del_flag) values ('49','46','0,1,31,40,41,46,','审核','50',NULL,NULL,NULL,'0','cms:link:audit','1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0'); 
 insert  into sys_menu(id,parent_id,parent_ids,name,sort,href,target,icon,is_show,permission,create_by,create_date,update_by,update_date,remarks,del_flag) values ('5','4','0,1,2,3,4,','查看','30',NULL,NULL,NULL,'0','sys:menu:view','1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0'); 
 insert  into sys_menu(id,parent_id,parent_ids,name,sort,href,target,icon,is_show,permission,create_by,create_date,update_by,update_date,remarks,del_flag) values ('50','40','0,1,31,40,','评论管理','40','/cms/comment/?status=2',NULL,'comment','1',NULL,'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0'); 
 insert  into sys_menu(id,parent_id,parent_ids,name,sort,href,target,icon,is_show,permission,create_by,create_date,update_by,update_date,remarks,del_flag) values ('51','50','0,1,31,40,50,','查看','30',NULL,NULL,NULL,'0','cms:comment:view','1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0'); 
 insert  into sys_menu(id,parent_id,parent_ids,name,sort,href,target,icon,is_show,permission,create_by,create_date,update_by,update_date,remarks,del_flag) values ('52','50','0,1,31,40,50,','审核','40',NULL,NULL,NULL,'0','cms:comment:edit','1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0'); 
 insert  into sys_menu(id,parent_id,parent_ids,name,sort,href,target,icon,is_show,permission,create_by,create_date,update_by,update_date,remarks,del_flag) values ('53','40','0,1,31,40,','公共留言','80','/cms/guestbook/?status=2',NULL,'glass','1',NULL,'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0');
 insert  into sys_menu(id,parent_id,parent_ids,name,sort,href,target,icon,is_show,permission,create_by,create_date,update_by,update_date,remarks,del_flag) values ('54','53','0,1,31,40,53,','查看','30',NULL,NULL,NULL,'0','cms:guestbook:view','1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0'); 
 insert  into sys_menu(id,parent_id,parent_ids,name,sort,href,target,icon,is_show,permission,create_by,create_date,update_by,update_date,remarks,del_flag) values ('55','53','0,1,31,40,53,','审核','40',NULL,NULL,NULL,'0','cms:guestbook:edit','1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0');
 insert  into sys_menu(id,parent_id,parent_ids,name,sort,href,target,icon,is_show,permission,create_by,create_date,update_by,update_date,remarks,del_flag) values ('56','71','0,1,27,71,','文件管理','90','/../static/ckfinder/ckfinder.html',NULL,'folder-open','1',NULL,'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0'); 
 insert  into sys_menu(id,parent_id,parent_ids,name,sort,href,target,icon,is_show,permission,create_by,create_date,update_by,update_date,remarks,del_flag) values ('57','56','0,1,27,40,56,','查看','30',NULL,NULL,NULL,'0','cms:ckfinder:view','1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0'); 
 insert  into sys_menu(id,parent_id,parent_ids,name,sort,href,target,icon,is_show,permission,create_by,create_date,update_by,update_date,remarks,del_flag) values ('58','56','0,1,27,40,56,','上传','40',NULL,NULL,NULL,'0','cms:ckfinder:upload','1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0'); 
 insert  into sys_menu(id,parent_id,parent_ids,name,sort,href,target,icon,is_show,permission,create_by,create_date,update_by,update_date,remarks,del_flag) values ('59','56','0,1,27,40,56,','修改','50',NULL,NULL,NULL,'0','cms:ckfinder:edit','1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0'); 
 insert  into sys_menu(id,parent_id,parent_ids,name,sort,href,target,icon,is_show,permission,create_by,create_date,update_by,update_date,remarks,del_flag) values ('6','4','0,1,2,3,4,','修改','40',NULL,NULL,NULL,'0','sys:menu:edit','1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0');
 insert  into sys_menu(id,parent_id,parent_ids,name,sort,href,target,icon,is_show,permission,create_by,create_date,update_by,update_date,remarks,del_flag) values ('60','31','0,1,31,','统计分析','600',NULL,NULL,NULL,'1',NULL,'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0'); 
 insert  into sys_menu(id,parent_id,parent_ids,name,sort,href,target,icon,is_show,permission,create_by,create_date,update_by,update_date,remarks,del_flag) values ('61','60','0,1,31,60,','信息量统计','30','/cms/stats/article',NULL,'tasks','1','cms:stats:article','1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0'); 
 insert  into sys_menu(id,parent_id,parent_ids,name,sort,href,target,icon,is_show,permission,create_by,create_date,update_by,update_date,remarks,del_flag) values ('62','1','0,1,','在线办公','200',NULL,NULL,NULL,'1',NULL,'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0'); 
 insert  into sys_menu(id,parent_id,parent_ids,name,sort,href,target,icon,is_show,permission,create_by,create_date,update_by,update_date,remarks,del_flag) values ('63','62','0,1,62,','个人办公','30',NULL,NULL,NULL,'1',NULL,'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0'); 
 insert  into sys_menu(id,parent_id,parent_ids,name,sort,href,target,icon,is_show,permission,create_by,create_date,update_by,update_date,remarks,del_flag) values ('64','63','0,1,62,63,','请假办理','300','/oa/leave',NULL,'leaf','0',NULL,'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0'); 
 insert  into sys_menu(id,parent_id,parent_ids,name,sort,href,target,icon,is_show,permission,create_by,create_date,update_by,update_date,remarks,del_flag) values ('65','64','0,1,62,63,64,','查看','30',NULL,NULL,NULL,'0','oa:leave:view','1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0'); 
 insert  into sys_menu(id,parent_id,parent_ids,name,sort,href,target,icon,is_show,permission,create_by,create_date,update_by,update_date,remarks,del_flag) values ('66','64','0,1,62,63,64,','修改','40',NULL,NULL,NULL,'0','oa:leave:edit','1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0'); 
 insert  into sys_menu(id,parent_id,parent_ids,name,sort,href,target,icon,is_show,permission,create_by,create_date,update_by,update_date,remarks,del_flag) values ('67','2','0,1,2,','日志查询','985',NULL,NULL,NULL,'1',NULL,'1',to_timestamp('2013-06-03 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1',to_timestamp('2013-06-03 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0'); 
 insert  into sys_menu(id,parent_id,parent_ids,name,sort,href,target,icon,is_show,permission,create_by,create_date,update_by,update_date,remarks,del_flag) values ('68','67','0,1,2,67,','日志查询','30','/sys/log',NULL,'pencil','1','sys:log:view','1',to_timestamp('2013-06-03 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1',to_timestamp('2013-06-03 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0'); 
 insert  into sys_menu(id,parent_id,parent_ids,name,sort,href,target,icon,is_show,permission,create_by,create_date,update_by,update_date,remarks,del_flag) values ('69','62','0,1,62,','流程管理','300',NULL,NULL,NULL,'1',NULL,'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0'); 
 insert  into sys_menu(id,parent_id,parent_ids,name,sort,href,target,icon,is_show,permission,create_by,create_date,update_by,update_date,remarks,del_flag) values ('7','3','0,1,2,3,','角色管理','50','/sys/role/',NULL,'lock','1',NULL,'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0'); 
 insert  into sys_menu(id,parent_id,parent_ids,name,sort,href,target,icon,is_show,permission,create_by,create_date,update_by,update_date,remarks,del_flag) values ('70','69','0,1,62,69,','流程管理','50','/act/process',NULL,'road','1','act:process:edit','1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0'); 
 insert  into sys_menu(id,parent_id,parent_ids,name,sort,href,target,icon,is_show,permission,create_by,create_date,update_by,update_date,remarks,del_flag) values ('71','27','0,1,27,','文件管理','90',NULL,NULL,NULL,'1',NULL,'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0'); 
 insert  into sys_menu(id,parent_id,parent_ids,name,sort,href,target,icon,is_show,permission,create_by,create_date,update_by,update_date,remarks,del_flag) values ('72','69','0,1,62,69,','模型管理','100','/act/model',NULL,'road','1','act:model:edit','1',to_timestamp('2013-09-20 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1',to_timestamp('2013-09-20 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0');
 insert  into sys_menu(id,parent_id,parent_ids,name,sort,href,target,icon,is_show,permission,create_by,create_date,update_by,update_date,remarks,del_flag) values ('73','63','0,1,62,63,','我的任务','50','/act/task/todo/',NULL,'tasks','1',NULL,'1',to_timestamp('2013-09-24 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1',to_timestamp('2013-09-24 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0'); 
 insert  into sys_menu(id,parent_id,parent_ids,name,sort,href,target,icon,is_show,permission,create_by,create_date,update_by,update_date,remarks,del_flag) values ('74','63','0,1,62,63,','审批测试','100','/oa/testAudit',NULL,NULL,'1','oa:testAudit:view,oa:testAudit:edit','1',to_timestamp('2013-09-24 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1',to_timestamp('2013-09-24 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0'); 
 insert  into sys_menu(id,parent_id,parent_ids,name,sort,href,target,icon,is_show,permission,create_by,create_date,update_by,update_date,remarks,del_flag) values ('75','1','0,1,','在线演示','3000',NULL,NULL,NULL,'1',NULL,'1',to_timestamp('2013-10-08 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1',to_timestamp('2013-10-08 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'1'); 
 insert  into sys_menu(id,parent_id,parent_ids,name,sort,href,target,icon,is_show,permission,create_by,create_date,update_by,update_date,remarks,del_flag) values ('79','1','0,1,','代码生成','5000',NULL,NULL,NULL,'1',NULL,'1',to_timestamp('2013-10-18 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1',to_timestamp('2013-10-18 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0'); 
 insert  into sys_menu(id,parent_id,parent_ids,name,sort,href,target,icon,is_show,permission,create_by,create_date,update_by,update_date,remarks,del_flag) values ('8','7','0,1,2,3,7,','查看','30',NULL,NULL,NULL,'0','sys:role:view','1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0'); 
 insert  into sys_menu(id,parent_id,parent_ids,name,sort,href,target,icon,is_show,permission,create_by,create_date,update_by,update_date,remarks,del_flag) values ('80','79','0,1,79,','代码生成','50',NULL,NULL,NULL,'1',NULL,'1',to_timestamp('2013-10-18 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1',to_timestamp('2013-10-18 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0');
 insert  into sys_menu(id,parent_id,parent_ids,name,sort,href,target,icon,is_show,permission,create_by,create_date,update_by,update_date,remarks,del_flag) values ('81','80','0,1,79,80,','生成方案配置','30','/gen/genScheme',NULL,NULL,'1','gen:genScheme:view,gen:genScheme:edit','1',to_timestamp('2013-10-18 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1',to_timestamp('2013-10-18 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0'); 
 insert  into sys_menu(id,parent_id,parent_ids,name,sort,href,target,icon,is_show,permission,create_by,create_date,update_by,update_date,remarks,del_flag) values ('82','80','0,1,79,80,','业务表配置','20','/gen/genTable',NULL,NULL,'1','gen:genTable:view,gen:genTable:edit,gen:genTableColumn:view,gen:genTableColumn:edit','1',to_timestamp('2013-10-18 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1',to_timestamp('2013-10-18 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0'); 
 insert  into sys_menu(id,parent_id,parent_ids,name,sort,href,target,icon,is_show,permission,create_by,create_date,update_by,update_date,remarks,del_flag) values ('83','80','0,1,79,80,','代码模板管理','90','/gen/genTemplate',NULL,NULL,'1','gen:genTemplate:view,gen:genTemplate:edit','1',to_timestamp('2013-10-18 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1',to_timestamp('2013-10-18 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'1'); 
 insert  into sys_menu(id,parent_id,parent_ids,name,sort,href,target,icon,is_show,permission,create_by,create_date,update_by,update_date,remarks,del_flag) values ('84','67','0,1,2,67,','连接池监视','40','/../druid',NULL,NULL,'1',NULL,'1',to_timestamp('2013-10-18 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1',to_timestamp('2013-10-18 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0'); 
 insert  into sys_menu(id,parent_id,parent_ids,name,sort,href,target,icon,is_show,permission,create_by,create_date,update_by,update_date,remarks,del_flag) values ('85','76','0,1,75,76,','行政区域','80','/../static/map/map-city.html',NULL,NULL,'1',NULL,'1',to_timestamp('2013-10-18 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1',to_timestamp('2013-10-18 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0'); 
 insert  into sys_menu(id,parent_id,parent_ids,name,sort,href,target,icon,is_show,permission,create_by,create_date,update_by,update_date,remarks,del_flag) values ('86','75','0,1,75,','组件演示','50',NULL,NULL,NULL,'1',NULL,'1',to_timestamp('2013-10-18 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1',to_timestamp('2013-10-18 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'1'); 
 insert  into sys_menu(id,parent_id,parent_ids,name,sort,href,target,icon,is_show,permission,create_by,create_date,update_by,update_date,remarks,del_flag) values ('87','86','0,1,75,86,','组件演示','30','/test/test/form',NULL,NULL,'1','test:test:view,test:test:edit','1',to_timestamp('2013-10-18 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1',to_timestamp('2013-10-18 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'1'); 
 insert  into sys_menu(id,parent_id,parent_ids,name,sort,href,target,icon,is_show,permission,create_by,create_date,update_by,update_date,remarks,del_flag) values ('88','62','0,1,62,','通知通告','20','','','','1','','1',to_timestamp('2013-11-08 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1',to_timestamp('2013-11-08 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0'); 
 insert  into sys_menu(id,parent_id,parent_ids,name,sort,href,target,icon,is_show,permission,create_by,create_date,update_by,update_date,remarks,del_flag) values ('89','88','0,1,62,88,','我的通告','30','/oa/oaNotify/self','','','1','','1',to_timestamp('2013-11-08 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1',to_timestamp('2013-11-08 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0'); 
 insert  into sys_menu(id,parent_id,parent_ids,name,sort,href,target,icon,is_show,permission,create_by,create_date,update_by,update_date,remarks,del_flag) values ('9','7','0,1,2,3,7,','修改','40',NULL,NULL,NULL,'0','sys:role:edit','1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0'); 
 insert  into sys_menu(id,parent_id,parent_ids,name,sort,href,target,icon,is_show,permission,create_by,create_date,update_by,update_date,remarks,del_flag) values ('90','88','0,1,62,88,','通告管理','50','/oa/oaNotify','','','1','oa:oaNotify:view,oa:oaNotify:edit','1',to_timestamp('2013-11-08 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1',to_timestamp('2013-11-08 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0');
 insert  into sys_menu(id,parent_id,parent_ids,name,sort,href,target,icon,is_show,permission,create_by,create_date,update_by,update_date,remarks,del_flag) values ('afab2db430e2457f9cf3a11feaa8b869','0ca004d6b1bf4bcab9670a5060d82a55','0,1,79,3c92c17886944d0687e73e286cada573,0ca004d6b1bf4bcab9670a5060d82a55,','编辑','60','','','','0','test:testTree:edit','1',to_timestamp('2013-08-12 13:10:05','yyyy-mm-dd hh24:mi:ss.ff'),'1',to_timestamp('2013-08-12 13:10:05','yyyy-mm-dd hh24:mi:ss.ff'),'','0'); 
 insert  into sys_menu(id,parent_id,parent_ids,name,sort,href,target,icon,is_show,permission,create_by,create_date,update_by,update_date,remarks,del_flag) values ('b1f6d1b86ba24365bae7fd86c5082317','3c92c17886944d0687e73e286cada573','0,1,79,3c92c17886944d0687e73e286cada573,','主子表','60','/test/testDataMain','','','1','','1',to_timestamp('2013-08-12 13:10:05','yyyy-mm-dd hh24:mi:ss.ff'),'1',to_timestamp('2013-08-12 13:10:05','yyyy-mm-dd hh24:mi:ss.ff'),'','0'); 
 insert  into sys_menu(id,parent_id,parent_ids,name,sort,href,target,icon,is_show,permission,create_by,create_date,update_by,update_date,remarks,del_flag) values ('ba8092291b40482db8fe7fc006ea3d76','3c92c17886944d0687e73e286cada573','0,1,79,3c92c17886944d0687e73e286cada573,','单表','30','/test/testData','','','1','','1',to_timestamp('2013-08-12 13:10:05','yyyy-mm-dd hh24:mi:ss.ff'),'1',to_timestamp('2013-08-12 13:10:05','yyyy-mm-dd hh24:mi:ss.ff'),'','0'); 
 insert  into sys_menu(id,parent_id,parent_ids,name,sort,href,target,icon,is_show,permission,create_by,create_date,update_by,update_date,remarks,del_flag) values ('c2e4d9082a0b4386884a0b203afe2c5c','0ca004d6b1bf4bcab9670a5060d82a55','0,1,79,3c92c17886944d0687e73e286cada573,0ca004d6b1bf4bcab9670a5060d82a55,','查看','30','','','','0','test:testTree:view','1',to_timestamp('2013-08-12 13:10:05','yyyy-mm-dd hh24:mi:ss.ff'),'1',to_timestamp('2013-08-12 13:10:05','yyyy-mm-dd hh24:mi:ss.ff'),'','0'); 
 insert  into sys_menu(id,parent_id,parent_ids,name,sort,href,target,icon,is_show,permission,create_by,create_date,update_by,update_date,remarks,del_flag) values ('d15ec45a4c5449c3bbd7a61d5f9dd1d2','b1f6d1b86ba24365bae7fd86c5082317','0,1,79,3c92c17886944d0687e73e286cada573,b1f6d1b86ba24365bae7fd86c5082317,','编辑','60','','','','0','test:testDataMain:edit','1',to_timestamp('2013-08-12 13:10:05','yyyy-mm-dd hh24:mi:ss.ff'),'1',to_timestamp('2013-08-12 13:10:05','yyyy-mm-dd hh24:mi:ss.ff'),'','0'); 
 insert  into sys_menu(id,parent_id,parent_ids,name,sort,href,target,icon,is_show,permission,create_by,create_date,update_by,update_date,remarks,del_flag) values ('df7ce823c5b24ff9bada43d992f373e2','ba8092291b40482db8fe7fc006ea3d76','0,1,79,3c92c17886944d0687e73e286cada573,ba8092291b40482db8fe7fc006ea3d76,','查看','30','','','','0','test:testData:view','1',to_timestamp('2013-08-12 13:10:05','yyyy-mm-dd hh24:mi:ss.ff'),'1',to_timestamp('2013-08-12 13:10:05','yyyy-mm-dd hh24:mi:ss.ff'),'','0');
 
commit;
/*Table structure for table `sys_office` */

-- 机构表
CREATE TABLE sys_office
(
	id varchar2(64) NOT NULL,
	parent_id varchar2(64) NOT NULL,
	parent_ids varchar2(2000) NOT NULL,
	name nvarchar2(100) NOT NULL,
	sort number(10,0) NOT NULL,
	area_id varchar2(64) NOT NULL,
	code varchar2(100),
	type char(1) NOT NULL,
	grade char(1) NOT NULL,
	address nvarchar2(255),
	zip_code varchar2(100),
	master nvarchar2(100),
	phone nvarchar2(200),
	fax nvarchar2(200),
	email nvarchar2(200),
	USEABLE varchar2(64),
	PRIMARY_PERSON varchar2(64),
	DEPUTY_PERSON varchar2(64),
	create_by varchar2(64) NOT NULL,
	create_date timestamp NOT NULL,
	update_by varchar2(64) NOT NULL,
	update_date timestamp NOT NULL,
	remarks nvarchar2(255),
	del_flag char(1) DEFAULT '0' NOT NULL,
	PRIMARY KEY (id)
);

/* 添加注释 */
comment on table sys_office is '机构表';
Comment on column sys_office.id is '编号';
Comment on column sys_office.parent_id is '父级编号';
Comment on column sys_office.parent_ids is '所有父级编号';
Comment on column sys_office.name is '名称';
Comment on column sys_office.sort is '排序';
Comment on column sys_office.area_id is '归属区域';
Comment on column sys_office.code is '区域编码';
Comment on column sys_office.type is '机构类型';
Comment on column sys_office.grade is '机构等级';
Comment on column sys_office.address is '联系地址';
Comment on column sys_office.zip_code is '邮政编码';
Comment on column sys_office.master is '负责人';
Comment on column sys_office.phone is '电话';
Comment on column sys_office.fax is '传真';
Comment on column sys_office.email is '邮箱';
Comment on column sys_office.USEABLE is '是否启用';
Comment on column sys_office.PRIMARY_PERSON is '主负责人';
Comment on column sys_office.DEPUTY_PERSON is '副负责人';
Comment on column sys_office.create_by is '创建者';
Comment on column sys_office.create_date is '创建时间';
Comment on column sys_office.update_by is '更新者';
Comment on column sys_office.update_date is '更新时间';
Comment on column sys_office.remarks is '备注信息';
Comment on column sys_office.del_flag is '删除标记';

/*Data for the table `sys_office` */

insert  into sys_office(id,parent_id,parent_ids,name,sort,area_id,code,type,grade,address,zip_code,master,phone,fax,email,USEABLE,PRIMARY_PERSON,DEPUTY_PERSON,create_by,create_date,update_by,update_date,remarks,del_flag) values ('1','0','0,','山东省总公司','10','2','100000','1','1',NULL,NULL,NULL,NULL,NULL,NULL,'1',NULL,NULL,'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0'); 
insert  into sys_office(id,parent_id,parent_ids,name,sort,area_id,code,type,grade,address,zip_code,master,phone,fax,email,USEABLE,PRIMARY_PERSON,DEPUTY_PERSON,create_by,create_date,update_by,update_date,remarks,del_flag) values ('10','7','0,1,7,','市场部','30','3','200003','2','2',NULL,NULL,NULL,NULL,NULL,NULL,'1',NULL,NULL,'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0'); 
insert  into sys_office(id,parent_id,parent_ids,name,sort,area_id,code,type,grade,address,zip_code,master,phone,fax,email,USEABLE,PRIMARY_PERSON,DEPUTY_PERSON,create_by,create_date,update_by,update_date,remarks,del_flag) values ('11','7','0,1,7,','技术部','40','3','200004','2','2',NULL,NULL,NULL,NULL,NULL,NULL,'1',NULL,NULL,'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0'); 
insert  into sys_office(id,parent_id,parent_ids,name,sort,area_id,code,type,grade,address,zip_code,master,phone,fax,email,USEABLE,PRIMARY_PERSON,DEPUTY_PERSON,create_by,create_date,update_by,update_date,remarks,del_flag) values ('12','7','0,1,7,','历城区分公司','0','4','201000','1','3',NULL,NULL,NULL,NULL,NULL,NULL,'1',NULL,NULL,'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0'); 
insert  into sys_office(id,parent_id,parent_ids,name,sort,area_id,code,type,grade,address,zip_code,master,phone,fax,email,USEABLE,PRIMARY_PERSON,DEPUTY_PERSON,create_by,create_date,update_by,update_date,remarks,del_flag) values ('13','12','0,1,7,12,','公司领导','10','4','201001','2','3',NULL,NULL,NULL,NULL,NULL,NULL,'1',NULL,NULL,'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0'); 
insert  into sys_office(id,parent_id,parent_ids,name,sort,area_id,code,type,grade,address,zip_code,master,phone,fax,email,USEABLE,PRIMARY_PERSON,DEPUTY_PERSON,create_by,create_date,update_by,update_date,remarks,del_flag) values ('14','12','0,1,7,12,','综合部','20','4','201002','2','3',NULL,NULL,NULL,NULL,NULL,NULL,'1',NULL,NULL,'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0'); 
insert  into sys_office(id,parent_id,parent_ids,name,sort,area_id,code,type,grade,address,zip_code,master,phone,fax,email,USEABLE,PRIMARY_PERSON,DEPUTY_PERSON,create_by,create_date,update_by,update_date,remarks,del_flag) values ('15','12','0,1,7,12,','市场部','30','4','201003','2','3',NULL,NULL,NULL,NULL,NULL,NULL,'1',NULL,NULL,'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0'); 
insert  into sys_office(id,parent_id,parent_ids,name,sort,area_id,code,type,grade,address,zip_code,master,phone,fax,email,USEABLE,PRIMARY_PERSON,DEPUTY_PERSON,create_by,create_date,update_by,update_date,remarks,del_flag) values ('16','12','0,1,7,12,','技术部','40','4','201004','2','3',NULL,NULL,NULL,NULL,NULL,NULL,'1',NULL,NULL,'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0'); 
insert  into sys_office(id,parent_id,parent_ids,name,sort,area_id,code,type,grade,address,zip_code,master,phone,fax,email,USEABLE,PRIMARY_PERSON,DEPUTY_PERSON,create_by,create_date,update_by,update_date,remarks,del_flag) values ('17','7','0,1,7,','历下区分公司','40','5','201010','1','3',NULL,NULL,NULL,NULL,NULL,NULL,'1',NULL,NULL,'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0'); 
insert  into sys_office(id,parent_id,parent_ids,name,sort,area_id,code,type,grade,address,zip_code,master,phone,fax,email,USEABLE,PRIMARY_PERSON,DEPUTY_PERSON,create_by,create_date,update_by,update_date,remarks,del_flag) values ('18','17','0,1,7,17,','公司领导','10','5','201011','2','3',NULL,NULL,NULL,NULL,NULL,NULL,'1',NULL,NULL,'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0'); 
insert  into sys_office(id,parent_id,parent_ids,name,sort,area_id,code,type,grade,address,zip_code,master,phone,fax,email,USEABLE,PRIMARY_PERSON,DEPUTY_PERSON,create_by,create_date,update_by,update_date,remarks,del_flag) values ('19','17','0,1,7,17,','综合部','20','5','201012','2','3',NULL,NULL,NULL,NULL,NULL,NULL,'1',NULL,NULL,'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0'); 
insert  into sys_office(id,parent_id,parent_ids,name,sort,area_id,code,type,grade,address,zip_code,master,phone,fax,email,USEABLE,PRIMARY_PERSON,DEPUTY_PERSON,create_by,create_date,update_by,update_date,remarks,del_flag) values ('2','1','0,1,','公司领导','10','2','100001','2','1',NULL,NULL,NULL,NULL,NULL,NULL,'1',NULL,NULL,'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0'); 
insert  into sys_office(id,parent_id,parent_ids,name,sort,area_id,code,type,grade,address,zip_code,master,phone,fax,email,USEABLE,PRIMARY_PERSON,DEPUTY_PERSON,create_by,create_date,update_by,update_date,remarks,del_flag) values ('20','17','0,1,7,17,','市场部','30','5','201013','2','3',NULL,NULL,NULL,NULL,NULL,NULL,'1',NULL,NULL,'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0'); 
insert  into sys_office(id,parent_id,parent_ids,name,sort,area_id,code,type,grade,address,zip_code,master,phone,fax,email,USEABLE,PRIMARY_PERSON,DEPUTY_PERSON,create_by,create_date,update_by,update_date,remarks,del_flag) values ('21','17','0,1,7,17,','技术部','40','5','201014','2','3',NULL,NULL,NULL,NULL,NULL,NULL,'1',NULL,NULL,'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0'); 
insert  into sys_office(id,parent_id,parent_ids,name,sort,area_id,code,type,grade,address,zip_code,master,phone,fax,email,USEABLE,PRIMARY_PERSON,DEPUTY_PERSON,create_by,create_date,update_by,update_date,remarks,del_flag) values ('22','7','0,1,7,','高新区分公司','50','6','201010','1','3',NULL,NULL,NULL,NULL,NULL,NULL,'1',NULL,NULL,'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0'); 
insert  into sys_office(id,parent_id,parent_ids,name,sort,area_id,code,type,grade,address,zip_code,master,phone,fax,email,USEABLE,PRIMARY_PERSON,DEPUTY_PERSON,create_by,create_date,update_by,update_date,remarks,del_flag) values ('23','22','0,1,7,22,','公司领导','10','6','201011','2','3',NULL,NULL,NULL,NULL,NULL,NULL,'1',NULL,NULL,'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0'); 
insert  into sys_office(id,parent_id,parent_ids,name,sort,area_id,code,type,grade,address,zip_code,master,phone,fax,email,USEABLE,PRIMARY_PERSON,DEPUTY_PERSON,create_by,create_date,update_by,update_date,remarks,del_flag) values ('24','22','0,1,7,22,','综合部','20','6','201012','2','3',NULL,NULL,NULL,NULL,NULL,NULL,'1',NULL,NULL,'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0'); 
insert  into sys_office(id,parent_id,parent_ids,name,sort,area_id,code,type,grade,address,zip_code,master,phone,fax,email,USEABLE,PRIMARY_PERSON,DEPUTY_PERSON,create_by,create_date,update_by,update_date,remarks,del_flag) values ('25','22','0,1,7,22,','市场部','30','6','201013','2','3',NULL,NULL,NULL,NULL,NULL,NULL,'1',NULL,NULL,'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0'); 
insert  into sys_office(id,parent_id,parent_ids,name,sort,area_id,code,type,grade,address,zip_code,master,phone,fax,email,USEABLE,PRIMARY_PERSON,DEPUTY_PERSON,create_by,create_date,update_by,update_date,remarks,del_flag) values ('26','22','0,1,7,22,','技术部','40','6','201014','2','3',NULL,NULL,NULL,NULL,NULL,NULL,'1',NULL,NULL,'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0'); 
insert  into sys_office(id,parent_id,parent_ids,name,sort,area_id,code,type,grade,address,zip_code,master,phone,fax,email,USEABLE,PRIMARY_PERSON,DEPUTY_PERSON,create_by,create_date,update_by,update_date,remarks,del_flag) values ('3','1','0,1,','综合部','20','2','100002','2','1',NULL,NULL,NULL,NULL,NULL,NULL,'1',NULL,NULL,'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0'); 
insert  into sys_office(id,parent_id,parent_ids,name,sort,area_id,code,type,grade,address,zip_code,master,phone,fax,email,USEABLE,PRIMARY_PERSON,DEPUTY_PERSON,create_by,create_date,update_by,update_date,remarks,del_flag) values ('4','1','0,1,','市场部','30','2','100003','2','1',NULL,NULL,NULL,NULL,NULL,NULL,'1',NULL,NULL,'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0'); 
insert  into sys_office(id,parent_id,parent_ids,name,sort,area_id,code,type,grade,address,zip_code,master,phone,fax,email,USEABLE,PRIMARY_PERSON,DEPUTY_PERSON,create_by,create_date,update_by,update_date,remarks,del_flag) values ('5','1','0,1,','技术部','40','2','100004','2','1',NULL,NULL,NULL,NULL,NULL,NULL,'1',NULL,NULL,'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0'); 
insert  into sys_office(id,parent_id,parent_ids,name,sort,area_id,code,type,grade,address,zip_code,master,phone,fax,email,USEABLE,PRIMARY_PERSON,DEPUTY_PERSON,create_by,create_date,update_by,update_date,remarks,del_flag) values ('6','1','0,1,','研发部','50','2','100005','2','1',NULL,NULL,NULL,NULL,NULL,NULL,'1',NULL,NULL,'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0'); 
insert  into sys_office(id,parent_id,parent_ids,name,sort,area_id,code,type,grade,address,zip_code,master,phone,fax,email,USEABLE,PRIMARY_PERSON,DEPUTY_PERSON,create_by,create_date,update_by,update_date,remarks,del_flag) values ('7','1','0,1,','济南市分公司','20','3','200000','1','2',NULL,NULL,NULL,NULL,NULL,NULL,'1',NULL,NULL,'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0'); 
insert  into sys_office(id,parent_id,parent_ids,name,sort,area_id,code,type,grade,address,zip_code,master,phone,fax,email,USEABLE,PRIMARY_PERSON,DEPUTY_PERSON,create_by,create_date,update_by,update_date,remarks,del_flag) values ('8','7','0,1,7,','公司领导','10','3','200001','2','2',NULL,NULL,NULL,NULL,NULL,NULL,'1',NULL,NULL,'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0'); 
insert  into sys_office(id,parent_id,parent_ids,name,sort,area_id,code,type,grade,address,zip_code,master,phone,fax,email,USEABLE,PRIMARY_PERSON,DEPUTY_PERSON,create_by,create_date,update_by,update_date,remarks,del_flag) values ('9','7','0,1,7,','综合部','20','3','200002','2','2',NULL,NULL,NULL,NULL,NULL,NULL,'1',NULL,NULL,'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0');

commit;

/*Table structure for table `sys_role` */

-- 角色表
CREATE TABLE sys_role
(
	id varchar2(64) NOT NULL,
	office_id varchar2(64),
	name nvarchar2(100) NOT NULL,
	enname varchar2(255),
	role_type varchar2(255),
	data_scope char(1),
	is_sys varchar2(64),
	useable varchar2(64),
	create_by varchar2(64) NOT NULL,
	create_date timestamp NOT NULL,
	update_by varchar2(64) NOT NULL,
	update_date timestamp NOT NULL,
	remarks nvarchar2(255),
	del_flag char(1) DEFAULT '0' NOT NULL,
	PRIMARY KEY (id)
);

/* 添加注释 */
comment on table sys_role is '角色表';
Comment on column sys_role.id is '编号';
Comment on column sys_role.office_id is '归属机构';
Comment on column sys_role.name is '角色名称';
Comment on column sys_role.enname is '英文名称';
Comment on column sys_role.role_type is '角色类型';
Comment on column sys_role.data_scope is '数据范围';
Comment on column sys_role.is_sys is '是否系统数据';
Comment on column sys_role.useable is '是否可用';
Comment on column sys_role.create_by is '创建者';
Comment on column sys_role.create_date is '创建时间';
Comment on column sys_role.update_by is '更新者';
Comment on column sys_role.update_date is '更新时间';
Comment on column sys_role.remarks is '备注信息';
Comment on column sys_role.del_flag is '删除标记';


/*Data for the table `sys_role` */

insert  into sys_role(id,office_id,name,enname,role_type,data_scope,is_sys,useable,create_by,create_date,update_by,update_date,remarks,del_flag) values ('1','1','系统管理员','dept','assignment','1',NULL,'1','1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0');
insert  into sys_role(id,office_id,name,enname,role_type,data_scope,is_sys,useable,create_by,create_date,update_by,update_date,remarks,del_flag) values ('2','1','公司管理员','hr','assignment','2',NULL,'1','1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0'); 
insert  into sys_role(id,office_id,name,enname,role_type,data_scope,is_sys,useable,create_by,create_date,update_by,update_date,remarks,del_flag) values ('3','1','本公司管理员','a','assignment','3',NULL,'1','1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0');
insert  into sys_role(id,office_id,name,enname,role_type,data_scope,is_sys,useable,create_by,create_date,update_by,update_date,remarks,del_flag) values ('4','1','部门管理员','b','assignment','4',NULL,'1','1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0');
insert  into sys_role(id,office_id,name,enname,role_type,data_scope,is_sys,useable,create_by,create_date,update_by,update_date,remarks,del_flag) values ('5','1','本部门管理员','c','assignment','5',NULL,'1','1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0');
insert  into sys_role(id,office_id,name,enname,role_type,data_scope,is_sys,useable,create_by,create_date,update_by,update_date,remarks,del_flag) values ('6','1','普通用户','d','assignment','8',NULL,'1','1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0');
insert  into sys_role(id,office_id,name,enname,role_type,data_scope,is_sys,useable,create_by,create_date,update_by,update_date,remarks,del_flag) values ('7','7','济南市管理员','e','assignment','9',NULL,'1','1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0');

commit;

/*Table structure for table `sys_role_menu` */


-- 角色-菜单
CREATE TABLE sys_role_menu
(
	role_id varchar2(64) NOT NULL,
	menu_id varchar2(64) NOT NULL,
	PRIMARY KEY (role_id, menu_id)
);

/* 添加注释 */
comment on table sys_role_menu is '角色-菜单';
Comment on column sys_role_menu.role_id is '角色编号';
Comment on column sys_role_menu.menu_id is '菜单编号';

/*Data for the table `sys_role_menu` */

insert  into sys_role_menu(role_id,menu_id) values ('1','1');
 insert  into sys_role_menu(role_id,menu_id) values ('1','10');
 insert  into sys_role_menu(role_id,menu_id) values ('1','11');
 insert  into sys_role_menu(role_id,menu_id) values ('1','12');
 insert  into sys_role_menu(role_id,menu_id) values ('1','13');
 insert  into sys_role_menu(role_id,menu_id) values ('1','14');
 insert  into sys_role_menu(role_id,menu_id) values ('1','15');
 insert  into sys_role_menu(role_id,menu_id) values ('1','16');
 insert  into sys_role_menu(role_id,menu_id) values ('1','17');
 insert  into sys_role_menu(role_id,menu_id) values ('1','18');
 insert  into sys_role_menu(role_id,menu_id) values ('1','19');
 insert  into sys_role_menu(role_id,menu_id) values ('1','2');
 insert  into sys_role_menu(role_id,menu_id) values ('1','20');
 insert  into sys_role_menu(role_id,menu_id) values ('1','21');
 insert  into sys_role_menu(role_id,menu_id) values ('1','22');
 insert  into sys_role_menu(role_id,menu_id) values ('1','23');
 insert  into sys_role_menu(role_id,menu_id) values ('1','24');
 insert  into sys_role_menu(role_id,menu_id) values ('1','25');
 insert  into sys_role_menu(role_id,menu_id) values ('1','26');
 insert  into sys_role_menu(role_id,menu_id) values ('1','27');
 insert  into sys_role_menu(role_id,menu_id) values ('1','28');
 insert  into sys_role_menu(role_id,menu_id) values ('1','29');
 insert  into sys_role_menu(role_id,menu_id) values ('1','3');
 insert  into sys_role_menu(role_id,menu_id) values ('1','30');
 insert  into sys_role_menu(role_id,menu_id) values ('1','31');
 insert  into sys_role_menu(role_id,menu_id) values ('1','32');
 insert  into sys_role_menu(role_id,menu_id) values ('1','33');
 insert  into sys_role_menu(role_id,menu_id) values ('1','34');
 insert  into sys_role_menu(role_id,menu_id) values ('1','35');
 insert  into sys_role_menu(role_id,menu_id) values ('1','36');
 insert  into sys_role_menu(role_id,menu_id) values ('1','37');
 insert  into sys_role_menu(role_id,menu_id) values ('1','38');
 insert  into sys_role_menu(role_id,menu_id) values ('1','39');
 insert  into sys_role_menu(role_id,menu_id) values ('1','4');
 insert  into sys_role_menu(role_id,menu_id) values ('1','40');
 insert  into sys_role_menu(role_id,menu_id) values ('1','41');
 insert  into sys_role_menu(role_id,menu_id) values ('1','42');
 insert  into sys_role_menu(role_id,menu_id) values ('1','43');
 insert  into sys_role_menu(role_id,menu_id) values ('1','44');
 insert  into sys_role_menu(role_id,menu_id) values ('1','45');
 insert  into sys_role_menu(role_id,menu_id) values ('1','46');
 insert  into sys_role_menu(role_id,menu_id) values ('1','47');
 insert  into sys_role_menu(role_id,menu_id) values ('1','48');
 insert  into sys_role_menu(role_id,menu_id) values ('1','49');
 insert  into sys_role_menu(role_id,menu_id) values ('1','5');
 insert  into sys_role_menu(role_id,menu_id) values ('1','50');
 insert  into sys_role_menu(role_id,menu_id) values ('1','51');
 insert  into sys_role_menu(role_id,menu_id) values ('1','52');
 insert  into sys_role_menu(role_id,menu_id) values ('1','53');
 insert  into sys_role_menu(role_id,menu_id) values ('1','54');
 insert  into sys_role_menu(role_id,menu_id) values ('1','55');
 insert  into sys_role_menu(role_id,menu_id) values ('1','56');
 insert  into sys_role_menu(role_id,menu_id) values ('1','57');
 insert  into sys_role_menu(role_id,menu_id) values ('1','58');
 insert  into sys_role_menu(role_id,menu_id) values ('1','59');
 insert  into sys_role_menu(role_id,menu_id) values ('1','6');
 insert  into sys_role_menu(role_id,menu_id) values ('1','60');
 insert  into sys_role_menu(role_id,menu_id) values ('1','61');
 insert  into sys_role_menu(role_id,menu_id) values ('1','62');
 insert  into sys_role_menu(role_id,menu_id) values ('1','63');
 insert  into sys_role_menu(role_id,menu_id) values ('1','64');
 insert  into sys_role_menu(role_id,menu_id) values ('1','65');
 insert  into sys_role_menu(role_id,menu_id) values ('1','66');
 insert  into sys_role_menu(role_id,menu_id) values ('1','67');
 insert  into sys_role_menu(role_id,menu_id) values ('1','68');
 insert  into sys_role_menu(role_id,menu_id) values ('1','69');
 insert  into sys_role_menu(role_id,menu_id) values ('1','7');
 insert  into sys_role_menu(role_id,menu_id) values ('1','70');
 insert  into sys_role_menu(role_id,menu_id) values ('1','71');
 insert  into sys_role_menu(role_id,menu_id) values ('1','72');
 insert  into sys_role_menu(role_id,menu_id) values ('1','73');
 insert  into sys_role_menu(role_id,menu_id) values ('1','74');
 insert  into sys_role_menu(role_id,menu_id) values ('1','75');
 insert  into sys_role_menu(role_id,menu_id) values ('1','76');
 insert  into sys_role_menu(role_id,menu_id) values ('1','77');
 insert  into sys_role_menu(role_id,menu_id) values ('1','78');
 insert  into sys_role_menu(role_id,menu_id) values ('1','79');
 insert  into sys_role_menu(role_id,menu_id) values ('1','8');
 insert  into sys_role_menu(role_id,menu_id) values ('1','80');
 insert  into sys_role_menu(role_id,menu_id) values ('1','81');
 insert  into sys_role_menu(role_id,menu_id) values ('1','82');
 insert  into sys_role_menu(role_id,menu_id) values ('1','83');
 insert  into sys_role_menu(role_id,menu_id) values ('1','84');
 insert  into sys_role_menu(role_id,menu_id) values ('1','85');
 insert  into sys_role_menu(role_id,menu_id) values ('1','86');
 insert  into sys_role_menu(role_id,menu_id) values ('1','87');
 insert  into sys_role_menu(role_id,menu_id) values ('1','88');
 insert  into sys_role_menu(role_id,menu_id) values ('1','89');
 insert  into sys_role_menu(role_id,menu_id) values ('1','9');
 insert  into sys_role_menu(role_id,menu_id) values ('1','90');
 insert  into sys_role_menu(role_id,menu_id) values ('2','1');
 insert  into sys_role_menu(role_id,menu_id) values ('2','10');
 insert  into sys_role_menu(role_id,menu_id) values ('2','11');
 insert  into sys_role_menu(role_id,menu_id) values ('2','12');
 insert  into sys_role_menu(role_id,menu_id) values ('2','13');
 insert  into sys_role_menu(role_id,menu_id) values ('2','14');
 insert  into sys_role_menu(role_id,menu_id) values ('2','15');
 insert  into sys_role_menu(role_id,menu_id) values ('2','16');
 insert  into sys_role_menu(role_id,menu_id) values ('2','17');
 insert  into sys_role_menu(role_id,menu_id) values ('2','18');
 insert  into sys_role_menu(role_id,menu_id) values ('2','19');
 insert  into sys_role_menu(role_id,menu_id) values ('2','2');
 insert  into sys_role_menu(role_id,menu_id) values ('2','20');
 insert  into sys_role_menu(role_id,menu_id) values ('2','21');
 insert  into sys_role_menu(role_id,menu_id) values ('2','22');
 insert  into sys_role_menu(role_id,menu_id) values ('2','23');
 insert  into sys_role_menu(role_id,menu_id) values ('2','24');
 insert  into sys_role_menu(role_id,menu_id) values ('2','25');
 insert  into sys_role_menu(role_id,menu_id) values ('2','26');
 insert  into sys_role_menu(role_id,menu_id) values ('2','27');
 insert  into sys_role_menu(role_id,menu_id) values ('2','28');
 insert  into sys_role_menu(role_id,menu_id) values ('2','29');
 insert  into sys_role_menu(role_id,menu_id) values ('2','3');
 insert  into sys_role_menu(role_id,menu_id) values ('2','30');
 insert  into sys_role_menu(role_id,menu_id) values ('2','31');
 insert  into sys_role_menu(role_id,menu_id) values ('2','32');
 insert  into sys_role_menu(role_id,menu_id) values ('2','33');
 insert  into sys_role_menu(role_id,menu_id) values ('2','34');
 insert  into sys_role_menu(role_id,menu_id) values ('2','35');
 insert  into sys_role_menu(role_id,menu_id) values ('2','36');
 insert  into sys_role_menu(role_id,menu_id) values ('2','37');
 insert  into sys_role_menu(role_id,menu_id) values ('2','38');
 insert  into sys_role_menu(role_id,menu_id) values ('2','39');
 insert  into sys_role_menu(role_id,menu_id) values ('2','4');
 insert  into sys_role_menu(role_id,menu_id) values ('2','40');
 insert  into sys_role_menu(role_id,menu_id) values ('2','41');
 insert  into sys_role_menu(role_id,menu_id) values ('2','42');
 insert  into sys_role_menu(role_id,menu_id) values ('2','43');
 insert  into sys_role_menu(role_id,menu_id) values ('2','44');
 insert  into sys_role_menu(role_id,menu_id) values ('2','45');
 insert  into sys_role_menu(role_id,menu_id) values ('2','46');
 insert  into sys_role_menu(role_id,menu_id) values ('2','47');
 insert  into sys_role_menu(role_id,menu_id) values ('2','48');
 insert  into sys_role_menu(role_id,menu_id) values ('2','49');
 insert  into sys_role_menu(role_id,menu_id) values ('2','5');
 insert  into sys_role_menu(role_id,menu_id) values ('2','50');
 insert  into sys_role_menu(role_id,menu_id) values ('2','51');
 insert  into sys_role_menu(role_id,menu_id) values ('2','52');
 insert  into sys_role_menu(role_id,menu_id) values ('2','53');
 insert  into sys_role_menu(role_id,menu_id) values ('2','54');
 insert  into sys_role_menu(role_id,menu_id) values ('2','55');
 insert  into sys_role_menu(role_id,menu_id) values ('2','56');
 insert  into sys_role_menu(role_id,menu_id) values ('2','57');
 insert  into sys_role_menu(role_id,menu_id) values ('2','58');
 insert  into sys_role_menu(role_id,menu_id) values ('2','59');
 insert  into sys_role_menu(role_id,menu_id) values ('2','6');
 insert  into sys_role_menu(role_id,menu_id) values ('2','60');
 insert  into sys_role_menu(role_id,menu_id) values ('2','61');
 insert  into sys_role_menu(role_id,menu_id) values ('2','62');
 insert  into sys_role_menu(role_id,menu_id) values ('2','63');
 insert  into sys_role_menu(role_id,menu_id) values ('2','64');
 insert  into sys_role_menu(role_id,menu_id) values ('2','65');
 insert  into sys_role_menu(role_id,menu_id) values ('2','66');
 insert  into sys_role_menu(role_id,menu_id) values ('2','67');
 insert  into sys_role_menu(role_id,menu_id) values ('2','68');
 insert  into sys_role_menu(role_id,menu_id) values ('2','69');
 insert  into sys_role_menu(role_id,menu_id) values ('2','7');
 insert  into sys_role_menu(role_id,menu_id) values ('2','70');
 insert  into sys_role_menu(role_id,menu_id) values ('2','71');
 insert  into sys_role_menu(role_id,menu_id) values ('2','72');
 insert  into sys_role_menu(role_id,menu_id) values ('2','73');
 insert  into sys_role_menu(role_id,menu_id) values ('2','74');
 insert  into sys_role_menu(role_id,menu_id) values ('2','75');
 insert  into sys_role_menu(role_id,menu_id) values ('2','76');
 insert  into sys_role_menu(role_id,menu_id) values ('2','77');
 insert  into sys_role_menu(role_id,menu_id) values ('2','78');
 insert  into sys_role_menu(role_id,menu_id) values ('2','79');
 insert  into sys_role_menu(role_id,menu_id) values ('2','8');
 insert  into sys_role_menu(role_id,menu_id) values ('2','80');
 insert  into sys_role_menu(role_id,menu_id) values ('2','81');
 insert  into sys_role_menu(role_id,menu_id) values ('2','82');
 insert  into sys_role_menu(role_id,menu_id) values ('2','83');
 insert  into sys_role_menu(role_id,menu_id) values ('2','84');
 insert  into sys_role_menu(role_id,menu_id) values ('2','85');
 insert  into sys_role_menu(role_id,menu_id) values ('2','86');
 insert  into sys_role_menu(role_id,menu_id) values ('2','87');
 insert  into sys_role_menu(role_id,menu_id) values ('2','88');
 insert  into sys_role_menu(role_id,menu_id) values ('2','89');
 insert  into sys_role_menu(role_id,menu_id) values ('2','9');
 insert  into sys_role_menu(role_id,menu_id) values ('2','90');
 insert  into sys_role_menu(role_id,menu_id) values ('3','1');
 insert  into sys_role_menu(role_id,menu_id) values ('3','10');
 insert  into sys_role_menu(role_id,menu_id) values ('3','11');
 insert  into sys_role_menu(role_id,menu_id) values ('3','12');
 insert  into sys_role_menu(role_id,menu_id) values ('3','13');
 insert  into sys_role_menu(role_id,menu_id) values ('3','14');
 insert  into sys_role_menu(role_id,menu_id) values ('3','15');
 insert  into sys_role_menu(role_id,menu_id) values ('3','16');
 insert  into sys_role_menu(role_id,menu_id) values ('3','17');
 insert  into sys_role_menu(role_id,menu_id) values ('3','18');
 insert  into sys_role_menu(role_id,menu_id) values ('3','19');
 insert  into sys_role_menu(role_id,menu_id) values ('3','2');
 insert  into sys_role_menu(role_id,menu_id) values ('3','20');
 insert  into sys_role_menu(role_id,menu_id) values ('3','21');
 insert  into sys_role_menu(role_id,menu_id) values ('3','22');
 insert  into sys_role_menu(role_id,menu_id) values ('3','23');
 insert  into sys_role_menu(role_id,menu_id) values ('3','24');
 insert  into sys_role_menu(role_id,menu_id) values ('3','25');
 insert  into sys_role_menu(role_id,menu_id) values ('3','26');
 insert  into sys_role_menu(role_id,menu_id) values ('3','27');
 insert  into sys_role_menu(role_id,menu_id) values ('3','28');
 insert  into sys_role_menu(role_id,menu_id) values ('3','29');
 insert  into sys_role_menu(role_id,menu_id) values ('3','3');
 insert  into sys_role_menu(role_id,menu_id) values ('3','30');
 insert  into sys_role_menu(role_id,menu_id) values ('3','31');
 insert  into sys_role_menu(role_id,menu_id) values ('3','32');
 insert  into sys_role_menu(role_id,menu_id) values ('3','33');
 insert  into sys_role_menu(role_id,menu_id) values ('3','34');
 insert  into sys_role_menu(role_id,menu_id) values ('3','35');
 insert  into sys_role_menu(role_id,menu_id) values ('3','36');
 insert  into sys_role_menu(role_id,menu_id) values ('3','37');
 insert  into sys_role_menu(role_id,menu_id) values ('3','38');
 insert  into sys_role_menu(role_id,menu_id) values ('3','39');
 insert  into sys_role_menu(role_id,menu_id) values ('3','4');
 insert  into sys_role_menu(role_id,menu_id) values ('3','40');
 insert  into sys_role_menu(role_id,menu_id) values ('3','41');
 insert  into sys_role_menu(role_id,menu_id) values ('3','42');
 insert  into sys_role_menu(role_id,menu_id) values ('3','43');
 insert  into sys_role_menu(role_id,menu_id) values ('3','44');
 insert  into sys_role_menu(role_id,menu_id) values ('3','45');
 insert  into sys_role_menu(role_id,menu_id) values ('3','46');
 insert  into sys_role_menu(role_id,menu_id) values ('3','47');
 insert  into sys_role_menu(role_id,menu_id) values ('3','48');
 insert  into sys_role_menu(role_id,menu_id) values ('3','49');
 insert  into sys_role_menu(role_id,menu_id) values ('3','5');
 insert  into sys_role_menu(role_id,menu_id) values ('3','50');
 insert  into sys_role_menu(role_id,menu_id) values ('3','51');
 insert  into sys_role_menu(role_id,menu_id) values ('3','52');
 insert  into sys_role_menu(role_id,menu_id) values ('3','53');
 insert  into sys_role_menu(role_id,menu_id) values ('3','54');
 insert  into sys_role_menu(role_id,menu_id) values ('3','55');
 insert  into sys_role_menu(role_id,menu_id) values ('3','56');
 insert  into sys_role_menu(role_id,menu_id) values ('3','57');
 insert  into sys_role_menu(role_id,menu_id) values ('3','58');
 insert  into sys_role_menu(role_id,menu_id) values ('3','59');
 insert  into sys_role_menu(role_id,menu_id) values ('3','6');
 insert  into sys_role_menu(role_id,menu_id) values ('3','60');
 insert  into sys_role_menu(role_id,menu_id) values ('3','61');
 insert  into sys_role_menu(role_id,menu_id) values ('3','62');
 insert  into sys_role_menu(role_id,menu_id) values ('3','63');
 insert  into sys_role_menu(role_id,menu_id) values ('3','64');
 insert  into sys_role_menu(role_id,menu_id) values ('3','65');
 insert  into sys_role_menu(role_id,menu_id) values ('3','66');
 insert  into sys_role_menu(role_id,menu_id) values ('3','67');
 insert  into sys_role_menu(role_id,menu_id) values ('3','68');
 insert  into sys_role_menu(role_id,menu_id) values ('3','69');
 insert  into sys_role_menu(role_id,menu_id) values ('3','7');
 insert  into sys_role_menu(role_id,menu_id) values ('3','70');
 insert  into sys_role_menu(role_id,menu_id) values ('3','71');
 insert  into sys_role_menu(role_id,menu_id) values ('3','72');
 insert  into sys_role_menu(role_id,menu_id) values ('3','73');
 insert  into sys_role_menu(role_id,menu_id) values ('3','74');
 insert  into sys_role_menu(role_id,menu_id) values ('3','75');
 insert  into sys_role_menu(role_id,menu_id) values ('3','76');
 insert  into sys_role_menu(role_id,menu_id) values ('3','77');
 insert  into sys_role_menu(role_id,menu_id) values ('3','78');
 insert  into sys_role_menu(role_id,menu_id) values ('3','79');
 insert  into sys_role_menu(role_id,menu_id) values ('3','8');
 insert  into sys_role_menu(role_id,menu_id) values ('3','80');
 insert  into sys_role_menu(role_id,menu_id) values ('3','81');
 insert  into sys_role_menu(role_id,menu_id) values ('3','82');
 insert  into sys_role_menu(role_id,menu_id) values ('3','83');
 insert  into sys_role_menu(role_id,menu_id) values ('3','84');
 insert  into sys_role_menu(role_id,menu_id) values ('3','85');
 insert  into sys_role_menu(role_id,menu_id) values ('3','86');
 insert  into sys_role_menu(role_id,menu_id) values ('3','87');
 insert  into sys_role_menu(role_id,menu_id) values ('3','88');
 insert  into sys_role_menu(role_id,menu_id) values ('3','89');
 insert  into sys_role_menu(role_id,menu_id) values ('3','9');
 insert  into sys_role_menu(role_id,menu_id) values ('3','90');

/*Table structure for table `sys_role_office` */

-- 角色-机构
CREATE TABLE sys_role_office
(
	role_id varchar2(64) NOT NULL,
	office_id varchar2(64) NOT NULL,
	PRIMARY KEY (role_id, office_id)
);

/* 添加注释 */
comment on table sys_role_office is '角色-机构';
Comment on column sys_role_office.role_id is '角色编号';
Comment on column sys_role_office.office_id is '机构编号';

/*Data for the table `sys_role_office` */

insert  into sys_role_office(role_id,office_id) values ('7','10');
 insert  into sys_role_office(role_id,office_id) values ('7','11');
 insert  into sys_role_office(role_id,office_id) values ('7','12');
 insert  into sys_role_office(role_id,office_id) values ('7','13');
 insert  into sys_role_office(role_id,office_id) values ('7','14');
 insert  into sys_role_office(role_id,office_id) values ('7','15');
 insert  into sys_role_office(role_id,office_id) values ('7','16');
 insert  into sys_role_office(role_id,office_id) values ('7','17');
 insert  into sys_role_office(role_id,office_id) values ('7','18');
 insert  into sys_role_office(role_id,office_id) values ('7','19');
 insert  into sys_role_office(role_id,office_id) values ('7','20');
 insert  into sys_role_office(role_id,office_id) values ('7','21');
 insert  into sys_role_office(role_id,office_id) values ('7','22');
 insert  into sys_role_office(role_id,office_id) values ('7','23');
 insert  into sys_role_office(role_id,office_id) values ('7','24');
 insert  into sys_role_office(role_id,office_id) values ('7','25');
 insert  into sys_role_office(role_id,office_id) values ('7','26');
 insert  into sys_role_office(role_id,office_id) values ('7','7');
 insert  into sys_role_office(role_id,office_id) values ('7','8');
 insert  into sys_role_office(role_id,office_id) values ('7','9');
 
 commit;

/*Table structure for table `sys_user` */

-- 用户表
CREATE TABLE sys_user
(
	id varchar2(64) NOT NULL,
	company_id varchar2(64) NOT NULL,
	office_id varchar2(64) NOT NULL,
	login_name varchar2(100) NOT NULL,
	password varchar2(100) NOT NULL,
	no varchar2(100),
	name nvarchar2(100) NOT NULL,
	email nvarchar2(200),
	phone varchar2(200),
	mobile varchar2(200),
	user_type char(1),
	photo varchar2(1000),
	login_ip varchar2(100),
	login_date timestamp,
	login_flag varchar2(64),
	create_by varchar2(64) NOT NULL,
	create_date timestamp NOT NULL,
	update_by varchar2(64) NOT NULL,
	update_date timestamp NOT NULL,
	remarks nvarchar2(255),
	del_flag char(1) DEFAULT '0' NOT NULL,
	PRIMARY KEY (id)
);

/* 添加注释 */
comment on table sys_user is '用户表';
Comment on column sys_user.id is '编号';
Comment on column sys_user.company_id is '归属公司';
Comment on column sys_user.office_id is '归属部门';
Comment on column sys_user.login_name is '登录名';
Comment on column sys_user.password is '密码';
Comment on column sys_user.no is '工号';
Comment on column sys_user.name is '姓名';
Comment on column sys_user.email is '邮箱';
Comment on column sys_user.phone is '电话';
Comment on column sys_user.mobile is '手机';
Comment on column sys_user.user_type is '用户类型';
Comment on column sys_user.photo is '用户头像';
Comment on column sys_user.login_ip is '最后登陆IP';
Comment on column sys_user.login_date is '最后登陆时间';
Comment on column sys_user.login_flag is '是否可登录';
Comment on column sys_user.create_by is '创建者';
Comment on column sys_user.create_date is '创建时间';
Comment on column sys_user.update_by is '更新者';
Comment on column sys_user.update_date is '更新时间';
Comment on column sys_user.remarks is '备注信息';
Comment on column sys_user.del_flag is '删除标记';

/*Data for the table `sys_user` */

insert  into sys_user(id,company_id,office_id,login_name,password,no,name,email,phone,mobile,user_type,photo,login_ip,login_date,login_flag,create_by,create_date,update_by,update_date,remarks,del_flag) values ('1','1','2','krazy','02a3f0772fcca9f415adc990734b45c6f059c7d33ee28362c4852032','0001','系统管理员','krazy@163.com','8675','8675',NULL,NULL,NULL,NULL,'1','1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'最高管理员','0');
 insert  into sys_user(id,company_id,office_id,login_name,password,no,name,email,phone,mobile,user_type,photo,login_ip,login_date,login_flag,create_by,create_date,update_by,update_date,remarks,del_flag) values ('10','7','11','jn_jsb','02a3f0772fcca9f415adc990734b45c6f059c7d33ee28362c4852032','0010','济南技术部',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0');
 insert  into sys_user(id,company_id,office_id,login_name,password,no,name,email,phone,mobile,user_type,photo,login_ip,login_date,login_flag,create_by,create_date,update_by,update_date,remarks,del_flag) values ('11','12','13','lc_admin','02a3f0772fcca9f415adc990734b45c6f059c7d33ee28362c4852032','0011','济南历城领导',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0');
 insert  into sys_user(id,company_id,office_id,login_name,password,no,name,email,phone,mobile,user_type,photo,login_ip,login_date,login_flag,create_by,create_date,update_by,update_date,remarks,del_flag) values ('12','12','18','lx_admin','02a3f0772fcca9f415adc990734b45c6f059c7d33ee28362c4852032','0012','济南历下领导',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0');
 insert  into sys_user(id,company_id,office_id,login_name,password,no,name,email,phone,mobile,user_type,photo,login_ip,login_date,login_flag,create_by,create_date,update_by,update_date,remarks,del_flag) values ('13','22','23','gx_admin','02a3f0772fcca9f415adc990734b45c6f059c7d33ee28362c4852032','0013','济南高新领导',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0');
 insert  into sys_user(id,company_id,office_id,login_name,password,no,name,email,phone,mobile,user_type,photo,login_ip,login_date,login_flag,create_by,create_date,update_by,update_date,remarks,del_flag) values ('2','1','2','sd_admin','02a3f0772fcca9f415adc990734b45c6f059c7d33ee28362c4852032','0002','管理员',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0');
 insert  into sys_user(id,company_id,office_id,login_name,password,no,name,email,phone,mobile,user_type,photo,login_ip,login_date,login_flag,create_by,create_date,update_by,update_date,remarks,del_flag) values ('3','1','3','sd_zhb','02a3f0772fcca9f415adc990734b45c6f059c7d33ee28362c4852032','0003','综合部',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0');
 insert  into sys_user(id,company_id,office_id,login_name,password,no,name,email,phone,mobile,user_type,photo,login_ip,login_date,login_flag,create_by,create_date,update_by,update_date,remarks,del_flag) values ('4','1','4','sd_scb','02a3f0772fcca9f415adc990734b45c6f059c7d33ee28362c4852032','0004','市场部',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0');
 insert  into sys_user(id,company_id,office_id,login_name,password,no,name,email,phone,mobile,user_type,photo,login_ip,login_date,login_flag,create_by,create_date,update_by,update_date,remarks,del_flag) values ('5','1','5','sd_jsb','02a3f0772fcca9f415adc990734b45c6f059c7d33ee28362c4852032','0005','技术部',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0');
 insert  into sys_user(id,company_id,office_id,login_name,password,no,name,email,phone,mobile,user_type,photo,login_ip,login_date,login_flag,create_by,create_date,update_by,update_date,remarks,del_flag) values ('6','1','6','sd_yfb','02a3f0772fcca9f415adc990734b45c6f059c7d33ee28362c4852032','0006','研发部',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0');
 insert  into sys_user(id,company_id,office_id,login_name,password,no,name,email,phone,mobile,user_type,photo,login_ip,login_date,login_flag,create_by,create_date,update_by,update_date,remarks,del_flag) values ('7','7','8','jn_admin','02a3f0772fcca9f415adc990734b45c6f059c7d33ee28362c4852032','0007','济南领导',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0');
 insert  into sys_user(id,company_id,office_id,login_name,password,no,name,email,phone,mobile,user_type,photo,login_ip,login_date,login_flag,create_by,create_date,update_by,update_date,remarks,del_flag) values ('8','7','9','jn_zhb','02a3f0772fcca9f415adc990734b45c6f059c7d33ee28362c4852032','0008','济南综合部',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0');
 insert  into sys_user(id,company_id,office_id,login_name,password,no,name,email,phone,mobile,user_type,photo,login_ip,login_date,login_flag,create_by,create_date,update_by,update_date,remarks,del_flag) values ('9','7','10','jn_scb','02a3f0772fcca9f415adc990734b45c6f059c7d33ee28362c4852032','0009','济南市场部',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1','1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),'1', to_timestamp('2013-05-27 08:00:00','yyyy-mm-dd hh24:mi:ss.ff'),NULL,'0');
 
 commit;

/*Table structure for table `sys_user_role` */

-- 用户-角色
CREATE TABLE sys_user_role
(
	user_id varchar2(64) NOT NULL,
	role_id varchar2(64) NOT NULL,
	PRIMARY KEY (user_id, role_id)
);

/* 添加注释 */
comment on table sys_user_role is '用户-角色';
Comment on column sys_user_role.user_id is '用户编号';
Comment on column sys_user_role.role_id is '角色编号';

/*Data for the table `sys_user_role` */

insert  into sys_user_role(user_id,role_id) values ('1','1');
 insert  into sys_user_role(user_id,role_id) values ('1','2');
 insert  into sys_user_role(user_id,role_id) values ('10','2');
 insert  into sys_user_role(user_id,role_id) values ('11','3');
 insert  into sys_user_role(user_id,role_id) values ('12','4');
 insert  into sys_user_role(user_id,role_id) values ('13','5');
 insert  into sys_user_role(user_id,role_id) values ('14','6');
 insert  into sys_user_role(user_id,role_id) values ('2','1');
 insert  into sys_user_role(user_id,role_id) values ('3','2');
 insert  into sys_user_role(user_id,role_id) values ('4','3');
 insert  into sys_user_role(user_id,role_id) values ('5','4');
 insert  into sys_user_role(user_id,role_id) values ('6','5');
 insert  into sys_user_role(user_id,role_id) values ('7','2');
 insert  into sys_user_role(user_id,role_id) values ('7','7');
 insert  into sys_user_role(user_id,role_id) values ('8','2');
 insert  into sys_user_role(user_id,role_id) values ('9','1');
 
 commit;

/*Table structure for table `test_data` */

CREATE TABLE test_data
(
	id varchar2(64) NOT NULL,
	user_id varchar2(64),
	office_id varchar2(64),
	area_id nvarchar2(64),
	name nvarchar2(100),
	sex char(1),
	in_date date,
	create_by varchar2(64) NOT NULL,
	create_date timestamp NOT NULL,
	update_by varchar2(64) NOT NULL,
	update_date timestamp NOT NULL,
	remarks nvarchar2(255),
	del_flag char(1) DEFAULT '0' NOT NULL,
	PRIMARY KEY (id)
);

/* Comments */

COMMENT ON TABLE test_data IS '业务数据表';
COMMENT ON COLUMN test_data.id IS '编号';
COMMENT ON COLUMN test_data.user_id IS '归属用户';
COMMENT ON COLUMN test_data.office_id IS '归属部门';
COMMENT ON COLUMN test_data.area_id IS '归属区域';
COMMENT ON COLUMN test_data.name IS '名称';
COMMENT ON COLUMN test_data.sex IS '性别';
COMMENT ON COLUMN test_data.in_date IS '加入日期';
COMMENT ON COLUMN test_data.create_by IS '创建者';
COMMENT ON COLUMN test_data.create_date IS '创建时间';
COMMENT ON COLUMN test_data.update_by IS '更新者';
COMMENT ON COLUMN test_data.update_date IS '更新时间';
COMMENT ON COLUMN test_data.remarks IS '备注信息';
COMMENT ON COLUMN test_data.del_flag IS '删除标记';


/*Data for the table `test_data` */

/*Table structure for table `test_data_child` */

CREATE TABLE test_data_child
(
	id varchar2(64) NOT NULL,
	test_data_main_id varchar2(64),
	name nvarchar2(100),
	create_by varchar2(64) NOT NULL,
	create_date timestamp NOT NULL,
	update_by varchar2(64) NOT NULL,
	update_date timestamp NOT NULL,
	remarks nvarchar2(255),
	del_flag char(1) DEFAULT '0' NOT NULL,
	PRIMARY KEY (id)
);

COMMENT ON TABLE test_data_child IS '业务数据子表';
COMMENT ON COLUMN test_data_child.id IS '编号';
COMMENT ON COLUMN test_data_child.test_data_main_id IS '业务主表ID';
COMMENT ON COLUMN test_data_child.name IS '名称';
COMMENT ON COLUMN test_data_child.create_by IS '创建者';
COMMENT ON COLUMN test_data_child.create_date IS '创建时间';
COMMENT ON COLUMN test_data_child.update_by IS '更新者';
COMMENT ON COLUMN test_data_child.update_date IS '更新时间';
COMMENT ON COLUMN test_data_child.remarks IS '备注信息';
COMMENT ON COLUMN test_data_child.del_flag IS '删除标记';

/*Data for the table `test_data_child` */

/*Table structure for table `test_data_main` */

CREATE TABLE test_data_main
(
	id varchar2(64) NOT NULL,
	user_id varchar2(64),
	office_id varchar2(64),
	area_id nvarchar2(64),
	name nvarchar2(100),
	sex char(1),
	in_date date,
	create_by varchar2(64) NOT NULL,
	create_date timestamp NOT NULL,
	update_by varchar2(64) NOT NULL,
	update_date timestamp NOT NULL,
	remarks nvarchar2(255),
	del_flag char(1) DEFAULT '0' NOT NULL,
	PRIMARY KEY (id)
);

COMMENT ON TABLE test_data_main IS '业务数据表';
COMMENT ON COLUMN test_data_main.id IS '编号';
COMMENT ON COLUMN test_data_main.user_id IS '归属用户';
COMMENT ON COLUMN test_data_main.office_id IS '归属部门';
COMMENT ON COLUMN test_data_main.area_id IS '归属区域';
COMMENT ON COLUMN test_data_main.name IS '名称';
COMMENT ON COLUMN test_data_main.sex IS '性别';
COMMENT ON COLUMN test_data_main.in_date IS '加入日期';
COMMENT ON COLUMN test_data_main.create_by IS '创建者';
COMMENT ON COLUMN test_data_main.create_date IS '创建时间';
COMMENT ON COLUMN test_data_main.update_by IS '更新者';
COMMENT ON COLUMN test_data_main.update_date IS '更新时间';
COMMENT ON COLUMN test_data_main.remarks IS '备注信息';
COMMENT ON COLUMN test_data_main.del_flag IS '删除标记';

/*Data for the table `test_data_main` */

/*Table structure for table `test_tree` */

CREATE TABLE test_tree
(
	id varchar2(64) NOT NULL,
	parent_id varchar2(64) NOT NULL,
	parent_ids varchar2(2000) NOT NULL,
	name nvarchar2(100) NOT NULL,
	sort number(10,0) NOT NULL,
	create_by varchar2(64) NOT NULL,
	create_date timestamp NOT NULL,
	update_by varchar2(64) NOT NULL,
	update_date timestamp NOT NULL,
	remarks nvarchar2(255),
	del_flag char(1) DEFAULT '0' NOT NULL,
	PRIMARY KEY (id)
);


COMMENT ON TABLE test_tree IS '树结构表';
COMMENT ON COLUMN test_tree.id IS '编号';
COMMENT ON COLUMN test_tree.parent_id IS '父级编号';
COMMENT ON COLUMN test_tree.parent_ids IS '所有父级编号';
COMMENT ON COLUMN test_tree.name IS '名称';
COMMENT ON COLUMN test_tree.sort IS '排序';
COMMENT ON COLUMN test_tree.create_by IS '创建者';
COMMENT ON COLUMN test_tree.create_date IS '创建时间';
COMMENT ON COLUMN test_tree.update_by IS '更新者';
COMMENT ON COLUMN test_tree.update_date IS '更新时间';
COMMENT ON COLUMN test_tree.remarks IS '备注信息';
COMMENT ON COLUMN test_tree.del_flag IS '删除标记';

/*Data for the table `test_tree` */



/* Create sys Indexes */

CREATE INDEX sys_area_parent_id ON sys_area (parent_id);
CREATE INDEX sys_area_parent_ids ON sys_area (parent_ids);
CREATE INDEX sys_area_del_flag ON sys_area (del_flag);
CREATE INDEX sys_dict_value ON sys_dict (value);
CREATE INDEX sys_dict_label ON sys_dict (label);
CREATE INDEX sys_dict_del_flag ON sys_dict (del_flag);
CREATE INDEX sys_log_create_by ON sys_log (create_by);
CREATE INDEX sys_log_request_uri ON sys_log (request_uri);
CREATE INDEX sys_log_type ON sys_log (type);
CREATE INDEX sys_log_create_date ON sys_log (create_date);
CREATE INDEX sys_mdict_parent_id ON sys_mdict (parent_id);
CREATE INDEX sys_mdict_parent_ids ON sys_mdict (parent_ids);
CREATE INDEX sys_mdict_del_flag ON sys_mdict (del_flag);
CREATE INDEX sys_menu_parent_id ON sys_menu (parent_id);
CREATE INDEX sys_menu_parent_ids ON sys_menu (parent_ids);
CREATE INDEX sys_menu_del_flag ON sys_menu (del_flag);
CREATE INDEX sys_office_parent_id ON sys_office (parent_id);
CREATE INDEX sys_office_parent_ids ON sys_office (parent_ids);
CREATE INDEX sys_office_del_flag ON sys_office (del_flag);
CREATE INDEX sys_office_type ON sys_office (type);
CREATE INDEX sys_role_del_flag ON sys_role (del_flag);
CREATE INDEX sys_role_enname ON sys_role (enname);
CREATE INDEX sys_user_office_id ON sys_user (office_id);
CREATE INDEX sys_user_login_name ON sys_user (login_name);
CREATE INDEX sys_user_company_id ON sys_user (company_id);
CREATE INDEX sys_user_update_date ON sys_user (update_date);
CREATE INDEX sys_user_del_flag ON sys_user (del_flag);

/* Create test Indexes */

CREATE INDEX test_data_del_flag ON test_data (del_flag);
CREATE INDEX test_data_child_del_flag ON test_data_child (del_flag);
CREATE INDEX test_data_main_del_flag ON test_data_main (del_flag);
CREATE INDEX test_tree_del_flag ON test_tree (del_flag);
CREATE INDEX test_data_parent_id ON test_tree (parent_id);
CREATE INDEX test_data_parent_ids ON test_tree (parent_ids);

/* Create cms Indexes */

CREATE INDEX cms_article_create_by ON cms_article (create_by);
CREATE INDEX cms_article_title ON cms_article (title);
CREATE INDEX cms_article_keywords ON cms_article (keywords);
CREATE INDEX cms_article_del_flag ON cms_article (del_flag);
CREATE INDEX cms_article_weight ON cms_article (weight);
CREATE INDEX cms_article_update_date ON cms_article (update_date);
CREATE INDEX cms_article_category_id ON cms_article (category_id);
CREATE INDEX cms_category_parent_id ON cms_category (parent_id);
CREATE INDEX cms_category_parent_ids ON cms_category (parent_ids);
CREATE INDEX cms_category_module ON cms_category (module);
CREATE INDEX cms_category_name ON cms_category (name);
CREATE INDEX cms_category_sort ON cms_category (sort);
CREATE INDEX cms_category_del_flag ON cms_category (del_flag);
CREATE INDEX cms_category_office_id ON cms_category (office_id);
CREATE INDEX cms_category_site_id ON cms_category (site_id);
CREATE INDEX cms_comment_category_id ON cms_comment (category_id);
CREATE INDEX cms_comment_content_id ON cms_comment (content_id);
CREATE INDEX cms_comment_status ON cms_comment (del_flag);
CREATE INDEX cms_guestbook_del_flag ON cms_guestbook (del_flag);
CREATE INDEX cms_link_category_id ON cms_link (category_id);
CREATE INDEX cms_link_title ON cms_link (title);
CREATE INDEX cms_link_del_flag ON cms_link (del_flag);
CREATE INDEX cms_link_weight ON cms_link (weight);
CREATE INDEX cms_link_create_by ON cms_link (create_by);
CREATE INDEX cms_link_update_date ON cms_link (update_date);
CREATE INDEX cms_site_del_flag ON cms_site (del_flag);



/* Create gen Indexes */

CREATE INDEX gen_scheme_del_flag ON gen_scheme (del_flag);
CREATE INDEX gen_table_name ON gen_table (name);
CREATE INDEX gen_table_del_flag ON gen_table (del_flag);
CREATE INDEX gen_table_column_table_id ON gen_table_column (gen_table_id);
CREATE INDEX gen_table_column_name ON gen_table_column (name);
CREATE INDEX gen_table_column_sort ON gen_table_column (sort);
CREATE INDEX gen_table_column_del_flag ON gen_table_column (del_flag);
CREATE INDEX gen_template_del_falg ON gen_template (del_flag);

