import Rails from '@rails/ujs';
import Turbolinks from 'turbolinks';
import $ from 'jquery';
global.$ = global.jQuery = $;
import { ClearRadio } from './sns/posts';
import { FormValidation } from './layouts/validation';
import { ClosetSelectValue } from './closet/posts';

document.addEventListener('turbolinks:load', () => {
    // ! フォームのバリデーションチェックをする関数
    FormValidation();

    // ! SNS投稿画面、SNS編集画面で選択したラジオボタンを解除する関数
    ClearRadio();

    // ! closet投稿画面、編集画面で大カテゴリーに基づいて小カテゴリーを表示する関数
    ClosetSelectValue();
});

Rails.start();
Turbolinks.start();