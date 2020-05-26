import Vue from "vue"
import s from "./store"
import Logo from "./components/Logo.vue"
import "./style.css"
import './style.scss';

// Lazy load scripts for components, not routes!
// const coolDiv = document.querySelector("#cool")
// if (coolDiv) import("./components/cool.js")

/* eslint-disable no-new */
new Vue({
  el: "#app",
  delimiters: ["${", "}"],
  components: {
    Logo
  },
  data: {
    privateState: {},
    sharedState: s.state
  },
  mounted() {
    console.log('mounted');
    this.navFunctions();
  },
  methods: {
    fadeToggle(el){
      if (el.classList.contains('is-paused')){
        el.classList.remove('is-paused')
      }
    },
    navFunctions(){
      /*
        Slidemenu
      */
      (function() {
        var $body = document.body
        , $menu_trigger = $body.getElementsByClassName('menu-trigger')[0];

        if ( typeof $menu_trigger !== 'undefined' ) {
          $menu_trigger.addEventListener('click', function() {
            $body.className = ( $body.className == 'menu-active' )? '' : 'menu-active';
          });
        }

      }).call(this);
    }
  }
})
/* eslint-enable */
