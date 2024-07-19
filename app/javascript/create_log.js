document.addEventListener('turbo:load', function() {
    const projectSelect = document.getElementById('project');
    const taskSelect = document.getElementById('task-select');

    const timerInput = document.querySelector('input[name="log_task[timer]"]');
    

    projectSelect.addEventListener('change', function() {
        const projectId = this.value;

        fetch(`/projects/${projectId}/tasks`)
            .then(response => response.json())
            .then(data => {
                let taskList = '';
                console.log(data)
                data.tasks.forEach(task => {
                    taskList += `<option value="${task.id}">${task.name}</option>`;
                });
                taskSelect.innerHTML = taskList;
            })
            .catch(error => console.error('Error fetching tasks:', error));
    });

    timerInput.addEventListener('input', function(e) {
        let value = e.target.value.replace(/[^0-9]/g, ''); // Hanya izinkan angka
    
        if (value.length > 0 && value[0] > '2') {
            value = '2' + value.slice(1); // Batasi angka pertama hingga maksimal 2
        }
        if (value.length > 1) {
            if (value[0] === '2' && value[1] > '3') {
                value = value.slice(0, 1) + '3' + value.slice(2); // Batasi angka kedua hingga maksimal 3 jika angka pertama adalah 2
            }
            if (value[0] !== '2' && value[1] > '9') {
                value = value.slice(0, 1) + '9' + value.slice(2); // Batasi angka kedua hingga maksimal 9 jika angka pertama bukan 2
            }
        }
        if (value.length > 2 && value[2] > '5') {
            value = value.slice(0, 2) + '5' + value.slice(3); // Batasi angka ketiga hingga maksimal 5
        }
        if (value.length > 3 && value[3] > '9') {
            value = value.slice(0, 3) + '9'; // Batasi angka keempat hingga maksimal 9
        }
    
        if (value.length > 4) {
            value = value.slice(0, 4); // Batasi input hingga 4 angka
        }
    
        if (value.length > 2) {
            value = value.slice(0, 2) + ':' + value.slice(2);
        } else if (value.length > 1) {
            value = value.slice(0, 2) + ':';
        }
    
        e.target.value = value;
    });
        
});
