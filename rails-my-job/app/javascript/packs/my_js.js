import dayjs from 'dayjs';
import Duration from 'dayjs/plugin/duration';
import RelativeTime from 'dayjs/plugin/relativeTime';

dayjs.extend(Duration);
dayjs.extend(RelativeTime);

const money = document.getElementById('money');
const current_game_time = document.getElementById('current_game_time');
const duration = document.getElementById('duration');
const starting_money = document.getElementById('starting_money');
const hourly_rate = parseFloat(document.getElementById('hourly_rate').value);
const time_speed = parseFloat(document.getElementById('running_speed').value);

const time_format = "YYYY-MM-DD HH:mm:ss" // 2021-04-24 21:32:34

// Game state
let account = parseFloat(starting_money.value);
let elapsed_in_ms = parseFloat(document.getElementById('game_time_in_ms').value);
let remaining = 1000000 - account;
let hours_more = remaining / hourly_rate;
let won = remaining < 0;

function earn() {
    elapsed_in_ms += (100 * time_speed);
    account += second_rate();
    remaining -= second_rate();
    if (remaining < 0) {
        won = true;
    }
    hours_more = remaining / hourly_rate;
};

let beginner_job = {
    hourly_rate: hourly_rate,
};

function second_rate() {
    return beginner_job.hourly_rate / 3600 * time_speed / 10;
};

const earningIntervalId = window.setInterval(earn, 100);

const stopEarning = () => window.clearInterval(earningIntervalId);
// window.setTimeout(stopEarning, 5000);

// Render init
const renderer = {
    init() {
    },

    render() {
        money.innerText = `$ ${account.toFixed(2)}`;
        duration.innerText = this.targetText();
        current_game_time.innerText = `${dayjs(elapsed_in_ms).format(time_format)}`;
    },

    targetText() {
        if(won){
            return `You've accomplished your goal! Congrats!!`
        }else {
            return `At this pace, it'll take ${this.humanReadableDuration()}.
          What woudl you do?`
        }
    },

    humanReadableDuration() {
        if (hours_more === Infinity) {
            return 'forever';
        } else {
            return dayjs.duration(hours_more, 'hours').humanize();
        }
    },
};

renderer.init();
window.setInterval(renderer.render.bind(renderer), 100);
