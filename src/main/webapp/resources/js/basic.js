'use strict';

//menu

const menu = document.querySelector('.menu');
const thema = document.querySelector('.thema');
const category = document.querySelector('.category1');

menu.addEventListener('mouseover' ,(e) => {
    let eventOj = e.target;

    if(eventOj.classList.contains('meal')){
        category.style.display='block';
    }

    if(eventOj.classList.contains('them')) {
        thema.style.display = 'block';
    }
})

category.addEventListener('mouseleave',()=> {
    category.style.display='none';
})

thema.addEventListener('mouseleave',()=> {
    thema.style.display='none';
})


// ============================================================