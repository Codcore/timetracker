$(document).on('turbolinks:load', function () {
    $('.add-task-btn').on('click', function (e) {
        e.preventDefault();
        $(this).hide();
        $('.task-form').toggle()
    })
})