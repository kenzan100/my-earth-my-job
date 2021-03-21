console.log("Hello");


// Game state
let account = 0;

function earn() {
    account += 1;
    console.log(account);
};

const earningIntervalId = window.setInterval(earn, 1000);
const stopEarning = () => window.clearInterval(earningIntervalId);
window.setTimeout(stopEarning, 5000);


// Render init
const canvas = document.getElementById('canvas');
const ctx = canvas.getContext('2d');

ctx.font = '50px serif';

const renderer = {
    render() {
        ctx.clearRect(0, 0, canvas.width, canvas.height);
        ctx.fillText(`$ ${account}`, 70, 90);
    },
};

window.setInterval(renderer.render.bind(renderer), 100);
