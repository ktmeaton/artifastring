# Artifastring

Artifastring ("artificial fast string") is a highly optimized
physical simulation of string quartet instruments (violins,
violas, and cellos) for sound synthesis.

Project webpage, description:
http://percival-music.ca/artifastring/

## Usage

```shell
git clone https://github.com/ktmeaton/artifastring
cd artifastring
docker build -t artifastring:latest .
```

```shell
docker run \
  --user $(id -u):$(id -g) \
  -v $PWD:/opt/artifastring \
  artifastring:latest \
  actions2wav examples/violin-g-major-pluck.actions
```

## Rewrite Notes

1. Reproduce sine wave (440 Hz).
2. Reproduce low pass audio convolution.
3. Reproduce body audio convolution.

- Is `string_audio_lowpass_input` useless?
  - No, it is a pointer to the input buffer of the convolution.
- Can we ignore most force buffers?
  - I think so.
- What is the convolution doing?