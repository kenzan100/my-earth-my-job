console.log("client index.js");

const money = document.getElementById('money');
const title = document.getElementById('title');
const starting_money = document.getElementById('starting_money');
const hourly_rate = parseFloat(document.getElementById('hourly_rate').value);

// Game state
let account = parseFloat(starting_money.value);

function earn() {
    account += second_rate();
};

let beginner_job = {
    hourly_rate: hourly_rate, // 11 USD
    title: 'Beginner Job',
};

function second_rate() {
    return beginner_job.hourly_rate / 3600;
};

const earningIntervalId = window.setInterval(earn, 1000);

const stopEarning = () => window.clearInterval(earningIntervalId);
// window.setTimeout(stopEarning, 5000);

// Render init
const renderer = {
    init() {
        title.innerText = beginner_job.title;
    },

    render() {
        money.innerText = `$ ${account.toFixed(2)}`;
    },
};

renderer.init();
window.setInterval(renderer.render.bind(renderer), 100);
