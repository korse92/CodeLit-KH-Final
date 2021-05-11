$(function() {
    //메뉴 드롭다운 호버 기능
    var $dropdownCommunity = $("#dropdownCommunity");
    var $dropdownLecture = $("#dropdownLecture");

    $("#navlinkDropdownCommunity, #dropdownCommunity").on('mouseover', function() {
      $dropdownCommunity.addClass("show");
    });
    $("#navlinkDropdownCommunity, #dropdownCommunity").on('mouseout', function() {
      $dropdownCommunity.removeClass("show");
    });
    $("#navlinkDropdownLecture, #dropdownLecture").on('mouseover', function() {
      $dropdownLecture.addClass("show");
    });
    $("#navlinkDropdownLecture, #dropdownLecture").on('mouseout', function() {
      $dropdownLecture.removeClass("show");
    });
});