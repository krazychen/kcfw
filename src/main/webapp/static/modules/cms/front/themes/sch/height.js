
/*导航栏二级菜单*/

$(function() {
    $(".nav li").hover(
        function() {
            $(this).find("ul").show(100);
        },
        function() {
            $(this).find("ul").hide(100);
        }
    );
});