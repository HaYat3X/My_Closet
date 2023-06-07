import Rails from '@rails/ujs';
import Turbolinks from 'turbolinks';
import { ClearRadio } from './sns/posts';
import $ from 'jquery';
global.$ = global.jQuery = $;

document.addEventListener('turbolinks:load', () => {
    // ! フォームのバリデーションチェック
    // * .needs-validationというクラス名が付いている要素を取得
    const forms = document.querySelectorAll('.needs-validation');

    // * 取得した各要素にイベントを追加 （各フォームの必須項目は一つではない可能性があるため）
    Array.from(forms).forEach((form) => {
        form.addEventListener('submit', (event) => {
            // ? 必須項目を入力している場合は、処理をスキップ
            if (!form.checkValidity()) {
                event.preventDefault();
                event.stopPropagation();
            }

            // ? 必須項目を入力していない場合は、エラー処理を発火
            form.classList.add('was-validated');
        });
    });

    // ! 選択しているラジオボタンを解除
    ClearRadio();
});

// クローゼットのセレクトボックスをリアルタイムにかんし
$(document).ready(function() {
    $('#big-category-select').change(function() {
        var selectedValue = $(this).val();
        console.log(selectedValue); // 選択された値をコンソールに表示

        // ここに選択内容に応じた処理を追加

        // // 例: Ajaxリクエストを送信してサーバーサイドに選択内容を送信
        // $.ajax({
        //     url: '/update_selected_value', // 適切なエンドポイントのURLを設定
        //     method: 'POST',
        //     data: { selected_value: selectedValue },
        //     success: function(response) {
        //         // サーバーサイドからのレスポンスを処理
        //         console.log(response);
        //     },
        //     error: function(error) {
        //         // エラーハンドリング
        //         console.log(error);
        //     }
        // });
    });
});

Rails.start();
Turbolinks.start();