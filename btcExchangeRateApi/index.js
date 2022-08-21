const Big = require('big.js');
const axios = require('axios').default;
const express = require('express');
const {differenceInMinutes} = require('date-fns');

let values = [];
let average = 0;
let lastBTCValue = 0;
const app = express();

// Make a request for the BTC values in USD
async function returnEuroRate() {
    const result = await axios.get('https://blockchain.info/ticker');
    return result.data.USD;    
}

// polls every 10 seconds the btc public Api and recalculates the average values polled in the last 10 minutes. Older values are truncated
setInterval(() => {
    returnEuroRate().then(
        function(response) {
            values.push({value: response.last, polledTime: new Date()})
            lastBTCValue = response.last
            
            let total = new Big(0);
            const numberOfValues = values.length;
            let lastIndexToShift = null;

            for (j=0;j<=numberOfValues-1;j++){
                const timestamp = values[j].polledTime
                if(differenceInMinutes(new Date(),timestamp) >= 10) {
                    lastIndexToShift = j;
                } else {
                    total = total.plus(values[j].value)
                }
            }

            if(lastIndexToShift !== null) {
                values.splice(0,lastIndexToShift + 1)
                lastIndexToShift = null;
            }

            average = total.div(values.length).toPrecision(15);
            console.log("Hello this is the average",average);
            console.log("Last polled BTC value", lastBTCValue);
        }
    );    
}, 10000);

app.get('/', function (req, res) {
    res.send(JSON.stringify({
        average,
        lastBTCValue
    }))
})

app.listen(80);
  