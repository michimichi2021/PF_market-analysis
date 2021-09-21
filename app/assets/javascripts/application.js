// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery3
//= require popper
//= require bootstrap-sprockets

//= require rails-ujs
//= require activestorage

//= require_tree .

//= require chartkick
//= require Chart.bundle


$(function() {
    $(".new_item").slick({
    slidesToShow: 4,
     autoplay: true,
     autoplaySpeed: 3000,
     dots: true, 
     centerMode: true,
     centerPadding: '60px',
     slidesToScroll: 1,
    responsive: [
      {
        breakpoint: 1200, // 768~1023px以下のサイズに適用
        settings: {
          slidesToShow: 3,
        },
      },
      {
        breakpoint: 992, // 480〜767px以下のサイズに適用
        settings: {
          slidesToShow: 2,
        },
      },
      {
        breakpoint: 768, // 〜479px以下のサイズに適用
        settings: {
          slidesToShow: 1,
        },
      },
    ],
  });
});

