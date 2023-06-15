import Rails from '@rails/ujs';
import Turbolinks from 'turbolinks';
import $ from 'jquery';
global.$ = global.jQuery = $;
import { ItemSelect, ItemScroll } from './sns/posts';
import { FormValidation } from './layouts/validation';
import { ClosetSelectValue } from './closet/posts';


document.addEventListener('turbolinks:load', () => {
    // ! フォームのバリデーションチェックをする関数
    FormValidation();

    // ! SNS投稿画面、SNS編集画面でアイテムを選択数や選択上限を制御
    ItemSelect();

    // ! closet投稿画面、編集画面で大カテゴリーに基づいて小カテゴリーを表示する関数
    ClosetSelectValue();

    // ! SNS投稿からアイテムスクロール処理を行う
    ItemScroll();

});


Rails.start();
Turbolinks.start();