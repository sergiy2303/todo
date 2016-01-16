$('<%= "##{@work.id} .work-body" %>').html("<%= j(render 'form', action: 'update') %>")
