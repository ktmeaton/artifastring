# Artifastring

Artifastring ("artificial fast string") is a highly optimized
physical simulation of string quartet instruments (violins,
violas, and cellos) for sound synthesis.

[Percival (2013) Physical Modelling meets Machine
Learning: Performing Music with a
Virtual String Ensemble](
https://percival-music.ca/research/phd-percival.pdf)

## Install

```bash
 git clone https://github.com/ktmeaton/artifastring
cd artifastring
docker build -t artifastring:latest .
docker run artifastring:latest actions2wav
```

```text
Usage: ./action2wav FILENAME.action {{OUTPUT_FILE}} {{INSTRUMENT_TYPE}} {{INSTRUMENT_NUMBER}} {{SAFE}}
```

## Quickstart

```bash
docker run -v $PWD:/opt/artifastring --rm artifastring:latest \
  actions2wav examples/violin-g-major.actions
```

## Instruments

| Instrument Type | Description | Instrument Number | Impulse |
| -- | -- | -- | -- |
| 0 | Violin | 0 | Violin I |
| 0 | Violin | 1 | Violin II |
| 0 | Violin | 2 | Violin III |
| 0 | Violin | 3 | Violin IV |
| 0 | Violin | 4 | Violin V |
| 1 | Viola | 0 | Viola I |
| 1 | Viola | 1 | Viola II |
| 2 | Cello | 0 | Cello I |
| 2 | Cello | 0 | Cello I |

>- Impulse wav files are in: `research/impulses/short-impulses`    
>- Impulse objects are in: `artifastring/constants/body_<instrument>_1.h`

A detailed overview of each instrument is provided in Percival (2013) Section 3.1 (p. 69)

```bash
docker run -v $PWD:/opt/artifastring -u $(id -u):$(id -g) --rm -it --entrypoint bash artifastring:latest

cd examples

actions2wav violin-g-major.actions violin-g-major_0.wav 0 0
actions2wav violin-g-major.actions violin-g-major_1.wav 0 1
actions2wav violin-g-major.actions violin-g-major_2.wav 0 2
actions2wav violin-g-major.actions violin-g-major_3.wav 0 3
actions2wav violin-g-major.actions violin-g-major_4.wav 0 4
```

## Actions

```text
action_type	seconds	parameters...
```

Lines must be divided with tabs, with one command per line.  A
line beginning with a `#` is a comment.

There are four types of commands. All commands begin with the `action_type` and `seconds`.  `seconds` is the absolute time since
the beginning of the audio, not the relative time since the last
command.

- **wait**: no extra parameters
  ```text
  w	2.0
  ```

- **finger**: 2 extra parameters: string number, and finger position
  ```text
  f	2.0	3	0.109101
  ```

- **pluck**: 3 extra parameters: string number, pluck position, and pluck force.
  ```text
  p	2.5	3	0.25	0.8
  ```

- **bow**: 4 extra parameters: string number, bow position, bow force, and bow velocity
  ```text
  b	3.0	3	0.12	0.6	0.4
  ```

- **accelerate** bow: 5 extra parameters: string number, bow position, bow force, target bow velocity, and bow acceleration
  ```text
  a	3.0	3	0.12	0.6	0.8	0.5
  ```

## Examples

```text
f	0.0	0	0.00
a	0.0	0	0.12	0.6	0.8	0.5
a	0.5	0	0.12	0.6	0.0	0.5
w	1.0
w	3.0
```

## Audio Processing

1. Gain too low.

    | Low Volume | Increase Clip Gain |
    | -- | -- |
    |![alt text](doc/images/violin-bow-volume.png) | ![Violin bow phase](doc/images/violin-bow-phase.png)|

2. Assymetric phase.

    | Assymetric Phase | Trim and Fade | Rotate Phase 90 |
    | -- | -- | -- |
    | ![Violin bow phase](doc/images/violin-bow-phase.png) | ![Violin bow phase](doc/images/violin-trim-fade.png) | ![Violin bow phase](doc/images/violin-rotate.png) |

## Notes

The highest stable bow velocity for violin is `2.0`.
