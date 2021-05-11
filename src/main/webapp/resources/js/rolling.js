$(function() {
    // 롤링
    setInterval(function() {      
        var rolling = $(".rolling ul");
        var rollingRow = $(".rolling ul li:first");

        var Area = function(){ 
            rollingRow.appendTo(rolling).show(300); 
        };

        $(rollingRow).hide(300, Area);         

        },3000
    );
});