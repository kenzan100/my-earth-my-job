console.log("client index.js");

// Game state
let account = 0;

function earn() {
    account += 1;
};

const earningIntervalId = window.setInterval(earn, 1000);
const stopEarning = () => window.clearInterval(earningIntervalId);

// Render init
const canvas = document.getElementById('canvas');
const renderer = {
    render() {
        canvas.innerText = `$ ${account}`;
    },
};

window.setInterval(renderer.render.bind(renderer), 100);
