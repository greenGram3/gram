'use strict'

const event_container = document.querySelector('.event_container'),
    event_list= event_container.querySelector('.event_list'),
    e_imgList =
        ['eventImage/event_01.png',
            'eventImage/event_02.png',
            'eventImage/event_03.png',
            'eventImage/event_04.png',
            'eventImage/event_05.png',
            'eventImage/event_06.png'],
    icon = event_container.querySelectorAll('button');

const e_li = event_list.getElementsByTagName('li');


for(let i = 0; i < e_imgList.length; i++){
    event_list.appendChild(document.createElement('li'))
        .style.background= `url(${e_imgList[i]})`;

}

// --------------------------------------------------------------
// event 슬라이더

let i = 0;

let slide = function() {
    e_li[i].style.left = '100%';
    e_li[i].style.opacity = '0';

    i++;
    i %= e_li.length;
    e_li[i].style.left= '0';
    e_li[i].style.opacity= '1';
};

let play = setInterval(slide, 3000);

// ---------------------------------------------------------------

// event play 버튼


event_list.addEventListener('click', (e) => {

    const eventOj = e.target;

    if (eventOj.classList.contains('pause')) {
        clearInterval(play);
        eventOj.classList.add('nonVisible');
        icon[0].classList.remove('nonVisible');
    }

    if(eventOj.classList.contains('play')){
        play = setInterval(slide, 3000);
        eventOj.classList.add('nonVisible');
        icon[1].classList.remove('nonVisible');
    }
});


// ============================================================

// best
const best_container = document.querySelector('.best_container'),
    best_section01 = best_container.querySelector('.best_section01'),
       best_section02 = best_container.querySelector('.best_section02'),

    best_list1 = best_section01.querySelector('.best_list'),
    best_list2 = best_section02.querySelector('.best_list'),

    b1_li = best_list1.getElementsByTagName('li'),
    b2_li = best_list2.getElementsByTagName('li'),

    btn = best_container.querySelectorAll('button');



// -------------------------------------------------------------

// best_section01 슬라이더 구현

let b1_endIdx =  b1_li.length - 4 ;

let b1_idx = 0;

function slide_img1(move, checked, self, other) {
    b1_idx += move;
    best_list1.style.left=`${-b1_idx * 25}%`;

    if (checked()) {
        self.classList.add('nonVisible');
    }else {
        other.classList.remove('nonVisible');
    }
}

btn[0].addEventListener('click', function() {
    slide_img1(-1, ()=> b1_idx <= 0, this, btn[1]);
});

btn[1].addEventListener('click',function() {
    slide_img1(1, ()=> b1_idx >= b1_endIdx, this, btn[0]);
});

// -----------------------------------------------------------------

// best_section02 슬라이더 구현

let b2_endIdx = b2_li.length - 4 ;

let b2_idx = 0;

function slide_img2(move, checked, self, other) {
    b2_idx += move;
    best_list2.style.left=`${-b2_idx * 25}%`;

    if (checked()) {
        self.classList.add('nonVisible');
    }else {
        other.classList.remove('nonVisible');
    }
}

btn[2].addEventListener('click', function() {
    slide_img2(-1, ()=> b2_idx <= 0, this, btn[3]);
});

btn[3].addEventListener('click',function() {
    slide_img2(1, ()=> b2_idx >= b2_endIdx, this, btn[2]);
});



//------------------------------------------------------------------
//
//
// // best
// const best_container = document.querySelector('.best_container'),
//     best_list = best_container.querySelector('.best_list'),
//     b_li = best_list.getElementsByTagName('li'),
//     b_imgList =
//         ['image/best_01.png',
//             'image/best_02.png',
//             'image/best_03.png',
//             'image/best_04.png',
//             'image/best_05.png',
//             'image/best_06.png',
//             'image/best_07.png',
//             'image/best_08.png'] ,
//     b_name = [
//         '상품1',
//         '상품2',
//         '상품3',
//         '상품4',
//         '상품5',
//         '상품6',
//         '상품7',
//         '상품8'
//     ],
//     b_price = [
//         '10,000원',
//         '20,000원',
//         '30,000원',
//         '40,000원',
//         '50,000원',
//         '60,000원',
//         '70,000원',
//         '80,000원'
//     ],
//     btn = best_container.querySelectorAll('button');
//
//
//
// for(let i = 0; i < b_imgList.length; i++) {
//     best_list.innerHTML +=
//         `<li>
//     <img src="${b_imgList[i]}">
//     <h4>${b_name[i]}</h4>
//     <p>${b_price[i]}</p>
//     </li>`;
// }
//
// // -------------------------------------------------------------
//
// // 슬라이더 구현
//
// let b_endIdx = b_li.length - 4 ;
// let b_idx = 0;
//
// function slide_img(move, checked, self, other) {
//     b_idx += move;
//     best_list.style.left=`${-b_idx * 25}%`;
//
//     if (checked()) {
//         self.classList.add('nonVisible');
//     }else {
//         other.classList.remove('nonVisible');
//     }
// }
//
//
// btn[1].addEventListener('click',function() {
//     slide_img(1, ()=> b_idx >= b_endIdx, this, btn[0]);
// });
//
//
// btn[0].addEventListener('click', function() {
//     slide_img(-1, ()=> b_idx <= 0, this, btn[1]);
// });
//
//
//
//
