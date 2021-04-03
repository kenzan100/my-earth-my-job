import dayjs from 'dayjs';
import Duration from 'dayjs/plugin/duration';
import RelativeTime from 'dayjs/plugin/relativeTime';

dayjs.extend(Duration);
dayjs.extend(RelativeTime);

const money = document.getElementById('money');
const title = document.getElementById('title');
const duration = document.getElementById('duration');
const starting_money = document.getElementById('starting_money');
const hourly_rate = parseFloat(document.getElementById('hourly_rate').value);

// Game state
let account = parseFloat(starting_money.value);
let remaining = 1000000 - account;
let hours_more = remaining / hourly_rate;
let won = remaining < 0;

function earn() {
    account += second_rate();
    remaining -= second_rate();
    if (remaining < 0) {
        won = true;
    }
    hours_more = remaining / hourly_rate;
    console.log(second_rate(), account, remaining);
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
        duration.innerText = this.targetText();
    },

    targetText() {
        if(won){
            return `You've accomplished your goal! Congrats!!`
        }else {
            return `At this pace, it'll take ${dayjs.duration(hours_more, 'hours').humanize()}.
          What woudl you do?`
        }
    },
};

renderer.init();
window.setInterval(renderer.render.bind(renderer), 100);
