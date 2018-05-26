import prifact from './prifact';

export function sumfact(i) {
    var thistime = i, lasttime = null;
    while (thistime !== lasttime) {
        lasttime = thistime;
        thistime = prifact(lasttime).reduce((t,x)=>t+x);
    }

    return thistime;
}