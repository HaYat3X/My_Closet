// ! SNS投稿画面、SNS編集画面で選択したラジオボタンを解除する関数
export function ClearRadio() {
    // * clear-radioというIDがついたボタンを取得する
    const clearButton = document.getElementById('clear-radio');

    // * radio-buttonというクラス名がついラジオボタンを未選択状態に変える
    if (clearButton) {
        clearButton.addEventListener('click', function() {
            const radioButtons = document.getElementsByClassName('radio-button');
            for (let i = 0; i < radioButtons.length; i++) {
                if (radioButtons[i].checked) {
                    radioButtons[i].checked = false;
                }
            }
        });
    }
}