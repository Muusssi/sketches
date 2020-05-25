import java.util.Iterator;
import processing.sound.*;

public static final int PEAK_TIMER = 1000;
public static final int BANDS = 512*16;
boolean timeline_on = true;
boolean reverse = true;
boolean flip = true;
FFT fft;
AudioIn in;


float[] spectrum = new float[BANDS];

float[][] timeline;
int timeline_offset = 0;

float[] peak_spectrum = new float[BANDS];
float peak_amplitude = 0.0;
int peak_frequency = 0;

void analyze() {
  fft.analyze(spectrum);
  float sum = 0.0;
  for(int i = 0; i < spectrum.length; i++){
    sum += spectrum[i];
  }
  if (peak_amplitude < sum) {
    peak_amplitude = sum;
    record_peak();
  }
  if (millis() > peak_timer) reset_peak();

  record_spectrum_on_timeline();
}

void record_spectrum_on_timeline() {
  if (timeline_on) {
    System.arraycopy(spectrum, 0, timeline[timeline_offset], 0, BANDS);
    if (reverse) {
      timeline_offset++;
      if (timeline_offset >= width) timeline_offset = 0;
    }
    else {
      timeline_offset--;
      if (timeline_offset <= 0) timeline_offset = width - 1;
    }
  }
}

void record_peak() {
  System.arraycopy(spectrum, 0, peak_spectrum, 0, BANDS);
  peak_timer = millis() + PEAK_TIMER;
}

void reset_peak() {
  peak_amplitude = 0;
}

void draw_spectrum(float[] spectrum, int offset) {
  for(int i = 0; i < spectrum.length; i++){
    stroke(mapped_color(spectrum[i]));
    line(i*2 + offset, height, i*2 + offset, height - spectrum[i]*height*20 );
  }
}

void draw_timespectrum() {
  loadPixels();
  int x = width - 1;
  for (int time = timeline_offset; time < width; ++time) {
    for (int band = 0; band < min(BANDS, height); ++band) {
      if (flip) {
        pixels[band*width + x] = mapped_color(timeline[time][band]);
      }
      else {
        pixels[band*width + x] = mapped_color(timeline[time][min(BANDS, height) - band -1]);
      }

    }
    x--;
  }
  for (int time = 0; time < timeline_offset; ++time) {
    for (int band = 0; band < min(BANDS, height); ++band) {
      if (flip) {
        pixels[band*width + x] = mapped_color(timeline[time][band]);
      }
      else {
        pixels[band*width + x] = mapped_color(timeline[time][min(BANDS, height) - band -1]);
      }
    }
    x--;
  }
  updatePixels();
}


void init_ftt() {
  fft = new FFT(this, BANDS);
  in = new AudioIn(this, 0);
  in.start();
  fft.input(in);
  timeline = new float[width][BANDS];
}





HashMap<String, ArrayList<float[]>> sample_map = new HashMap<String, ArrayList<float[]>>();

void record_sample(String name) {
  float[] sample = new float[BANDS];
  System.arraycopy(peak_spectrum, 0, sample, 0, BANDS);
  normalize_sample_amplitudes(sample);
  if (!sample_map.containsKey(name)) {
    sample_map.put(name, new ArrayList<float[]>());
  }
  sample_map.get(name).add(sample);
}

void normalize_sample_amplitudes(float[] sample) {
  float max_amplitude = 0;
  for (int i = 0; i < BANDS; ++i) {
    if (max_amplitude < sample[i]) {
      max_amplitude = sample[i];
    }
  }
  for (int i = 0; i < BANDS; ++i) {
    sample[i] = sample[i]/max_amplitude;
  }
}


void compare_to_all_samples() {
  float[] normalized_sample = new float[BANDS];
  System.arraycopy(peak_spectrum, 0, normalized_sample, 0, BANDS);
  normalize_sample_amplitudes(normalized_sample);

  Iterator<String> key_iterator = sample_map.keySet().iterator();
  while (key_iterator.hasNext()) {
    String name = key_iterator.next();

    ArrayList<float[]> samples = sample_map.get(name);
    for (float[] sample : samples) {
      float diff = compare_samples(sample, normalized_sample);
      println(name + ": " + diff);
    }

  }
}


float compare_samples(float[] sample1, float[] sample2) {
  float diff = 0;
  for (int i = 0; i < BANDS; ++i) {
    diff += (sample1[i] - sample2[i])*(sample1[i] - sample2[i]);
  }
  return diff;
}


public static final float LOW  = 0.0001;
public static final float MID1 = 0.001;
public static final float MID2 = 0.01;
public static final float HIGH = 0.1;

int mapped_color(float value) {
  if (value < LOW) return color(0, 0, map(value, 0, LOW, 0, 255));
  if (value < MID1) return color(0, map(value, LOW, MID1, 0, 255), map(value, LOW, MID1, 255, 0));
  if (value < MID2) return color(map(value, MID1, MID2, 0, 255), map(value, MID1, MID2, 255, 0), 0);
  if (value < HIGH) return color(255, map(value, MID2, HIGH, 0, 255), map(value, MID2, HIGH, 0, 255));
  return color(255, 255, 255);
}
