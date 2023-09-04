import Rails from '@rails/ujs';
import Turbolinks from 'turbolinks';
import $ from 'jquery';
global.$ = global.jQuery = $;
import {
    SnsNewItemSelect,
    SnsListSwitching,
    SnsPostFileReset,
} from './sns/posts';
import { FormValidation } from './layouts/validation';
import { ClosetSelectValue, ClosetBrandValue } from './closet/posts';
import { ModalWindow } from './layouts/modal';

// document.addEventListener('turbolinks:load', () => {
//     // ! フォームのバリデーションチェックをする関数
//     FormValidation();

//     // !モーダルウィンドを表示する関数
//     ModalWindow();

//     // ! SNS一覧画面でフォロー中と全ての投稿を切り替える
//     SnsListSwitching();

//     // ! SNS投稿画面で着用アイテムの選択数や選択上限、選択した場合のUIを制御
//     SnsNewItemSelect();

//     // ! SNS投稿画面で画像選択をキャンセルする
//     SnsPostFileReset();

//     // ! closet投稿画面、編集画面で大カテゴリーに基づいて小カテゴリーを表示する関数
//     ClosetSelectValue();

//     ClosetBrandValue();

//     $(function() {
//         $('form').on('submit', function() {
//             $('.loading_btn').hide();
//             $('.loading').show();
//         });
//     });

//     // ! 一定期間でフラッシュメッセージを非表示にする
//     $(function() {
//         $('.alerts').fadeOut(5000); //４秒かけて消えていく
//     });
// });

Rails.start();
Turbolinks.start();