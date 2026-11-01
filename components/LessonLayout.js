.pragma library

function modelToArray(source) {
  if (!source)
    return [];
  if (Array.isArray(source))
    return source.slice();

  const out = [];
  for (let i = 0; i < source.count; ++i)
    out.push(source.get(i));

  return out;
}

function compute(model, start, end) {
  const origin = start.getTime();
  const span = end.getTime() - origin;
  const frac = ms => (span ? (ms - origin) / span : 0); // get how much space the lesson should take in the view as a fraction

  const sorted = modelToArray(model).sort((a, b) => a.startTime - b.startTime); // create sorted array from the model

  const out = [];
  let laneEnds = [];
  let groupStart = 0;

  const setLaneCounts = () => { // update the lane counts in the items
    for (let i = groupStart; i < out.length; ++i)
      out[i].laneCount = laneEnds.length;
  };

  for (const lesson of sorted) {
    const start = lesson.startTime.getTime();
    const end = lesson.stopTime.getTime();

    if (laneEnds.length && laneEnds.every(laneEnd => laneEnd <= start)) { // if the previous lane ends are smaller than start, finish the lane and create a new one
      setLaneCounts();
      groupStart = out.length;
      laneEnds = [];
    }

    let lane = laneEnds.findIndex(laneEnd => laneEnd <= start); // find the first overlapping lane and
    if (lane == -1) { // if there is no overlapping lane end, crete a new laneg
      lane = laneEnds.length;
      laneEnds.push(end);
    } else { // if there is an overlapping lane end, push that lane end until the end of the current end variable
      laneEnds[lane] = end;
    }

    out.push({
      lesson,
      top: frac(start),
      height: frac(end) - frac(start),
      lane
    }); // add the lesson to the array
  }

  setLaneCounts();
  return out;
}
