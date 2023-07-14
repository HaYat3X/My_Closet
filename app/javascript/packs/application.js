import Rails from '@rails/ujs';
import Turbolinks from 'turbolinks';
import $ from 'jquery';
global.$ = global.jQuery = $;
import { SnsNewItemSelect, SnsListSwitching } from './sns/posts';
import { FormValidation } from './layouts/validation';
import { ClosetSelectValue, ClosetBrandValue } from './closet/posts';

document.addEventListener('turbolinks:load', () => {
    // ! SNS一覧画面でフォロー中と全ての投稿を切り替える
    SnsListSwitching();

    // ! フォームのバリデーションチェックをする関数
    FormValidation();

    // ! SNS投稿画面で着用アイテムの選択数や選択上限、選択した場合のUIを制御
    SnsNewItemSelect();

    // ! closet投稿画面、編集画面で大カテゴリーに基づいて小カテゴリーを表示する関数
    ClosetSelectValue();

    ClosetBrandValue();

    $(function() {
        $('form').on('submit', function() {
            $('.loading_btn').hide();
            $('.loading').show();
        });
    });

    // ! 一定期間でフラッシュメッセージを非表示にする
    $(function() {
        $('.alerts').fadeOut(5000); //４秒かけて消えていく
    });
});

Rails.start();
Turbolinks.start();