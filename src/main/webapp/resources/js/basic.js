'use strict';

//menu

const menu = document.querySelector('.menu');
const thema = document.querySelector('.thema');
const category01 = document.querySelector('#category01');

menu.addEventListener('mouseover' ,(e) => {
    let eventOj = e.target;

    if(eventOj.classList.contains('meal')){
        category01.style.display='block';
    }

    if(eventOj.classList.contains('them')) {
        thema.style.display = 'block';
    }
})

category01.addEventListener('mouseleave',()=> {
    category01.style.display='none';
})

thema.addEventListener('mouseleave',()=> {
    thema.style.display='none';
})


// ============================================================