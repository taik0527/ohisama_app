for (const element of document.querySelectorAll('.modal .delete, .show-modal')) {
    element.addEventListener('click', e => {
        const modalId = element.dataset.target;
        const modal = document.getElementById(modalId);
        modal.classList.toggle('is-active');
    });
}