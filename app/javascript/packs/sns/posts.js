// ! SNS一覧画面でフォロー中と全ての投稿を切り替える
export function SnsListSwitching() {
    document.addEventListener('DOMContentLoaded', () => {
        const checkbox = document.getElementById('formSwitchCheckDefault');
        const form = document.getElementById('myForm');

        checkbox.addEventListener('change', () => {
            form.submit();
        });
    });
}


// ! SNS投稿画面で着用アイテムの選択数や選択上限、選択した場合のUIを制御
export function SnsNewItemSelect() {
    // * 選択できるアイテムの上限を設定
    var maxSelection = 6;

    // * チェックボックスの要素を変数に格納
    var checkboxes = $('.checkbox-image');

    // * 選択された画像が入る配列を定義
    var selectedImages = [];

    // * 選択順に番号を表示するためにカウンター
    var markCounter = 1;

    // * 選択数が6件超えた場合に、エラーメッセージを表示する要素を変数に格納
    var messageContainer = $('#messageContainer');

    // * チェックボックスの状態を取得
    checkboxes.change(function() {
        // ? 選択されているチェックボックスの数を取得
        var selectedCount = checkboxes.filter(':checked').length;
        var image = $(this).prev('.checkbox-image-label').find('img');
        var label = $(this).prev('.checkbox-image-label');

        if ($(this).is(':checked')) {
            // ? 画像が選択された場合
            if (selectedCount <= maxSelection) {
                // 選択数が最大選択数以下の場合は、選択された順に画像の上に番号を表示
                var mark = $('<span class="image-mark">' + markCounter + '</span>');
                markCounter++;
                selectedImages.push({
                    image: image,
                    mark: mark
                });
                // cssの適用
                image.addClass('selected-image');
                label.append(mark).css('position', 'relative');
            } else {
                // 選択数が最大選択数を超えた場合は、チェックできないようにする
                $(this).prop('checked', false);
                // エラーメッセージの表示
                showMessage('アイテムの最大選択数は6アイテムまでです。');
            }
        } else {
            // ? 画像が選択解除された場合
            var index = selectedImages.findIndex(function(item) {
                return item.image.is(image);
            });
            if (index > -1) {
                // 選択された画像が配列内に存在する場合は、cssの適用を解除
                var removedItem = selectedImages.splice(index, 1)[0];
                removedItem.image.removeClass('selected-image');
                removedItem.mark.remove();
            }
            // カウンターを1減らし、番号を再度適用する
            selectedImages.forEach(function(item, index) {
                item.mark.text(index + 1);
            });
            // カウンターを1減らす
            markCounter--;
        }

        // ? 選択されたアイテムが6件以下の場合は、エラーメッセージの表示を解除
        if (selectedCount <= maxSelection) {
            hideMessage();
        }
    });

    // * エラーメッセージを表示する関数
    function showMessage(message) {
        messageContainer.text(message).show();
    }

    // * エラーメッセージを非表示にする関数
    function hideMessage() {
        messageContainer.hide();
    }
}