import Rails from '@rails/ujs';
import Turbolinks from 'turbolinks';
import { ClearRadio } from './sns/posts';

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

Rails.start();
Turbolinks.start();