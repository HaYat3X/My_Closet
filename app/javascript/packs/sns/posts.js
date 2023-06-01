export function ClearRadio() {
    const clearButton = document.getElementById('clear-radio');
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