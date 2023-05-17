import Rails from "@rails/ujs";
import Turbolinks from "turbolinks";

// 無効なフィールドがある場合にフォーム送信を無効にするスターターJavaScriptの例
(() => {
  "use strict";

  // Bootstrapカスタム検証スタイルを適用してすべてのフォームを取得
  const forms = document.querySelectorAll(".needs-validation");

  // ループして帰順を防ぐ
  Array.from(forms).forEach((form) => {
    form.addEventListener(
      "submit",
      (event) => {
        if (!form.checkValidity()) {
          event.preventDefault();
          event.stopPropagation();
        }

        form.classList.add("was-validated");
      },
      false
    );
  });
})();

Rails.start();
Turbolinks.start();
