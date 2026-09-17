# PID-CONTROLLER-PROJECT
## Systematic Controller Tuning — Direct Synthesis (IMC)

The manually-tuned PID gains (Kp=1, Ki=0.5, Kd=1) were selected by observing 
the effect of each term individually. While this achieved zero steady-state 
error, it resulted in significant overshoot (51.2%) and a long settling time 
(121.3s).

To arrive at a systematically derived set of gains, **Ziegler-Nichols tuning 
was considered but does not apply here** — both Z-N methods require either 
sustained oscillation under proportional-only control, or a delayed 
(S-shaped) reaction curve. Since the plant is a pure first-order system with 
no dead time (G(s) = 2/(50s+1)), it cannot sustain oscillation under any 
proportional gain, so no "ultimate gain" exists to base Z-N on.

Instead, **Direct Synthesis (Internal Model Control) tuning** was applied — 
the correct systematic method for a delay-free first-order plant:

**Kp = τ / (K·λ)**
**Ki = Kp / τ**

Where τ = 50 (plant time constant), K = 2 (plant gain), and λ = 10s 
(chosen closed-loop speed, faster than the open-loop plant but conservative 
enough to avoid oscillation).

**Resulting gains: Kp = 2.5, Ki = 0.05, Kd = 0**

(No derivative term is needed — since the plant itself has no oscillatory 
dynamics, the oscillation seen in the manually-tuned PID response came from 
the integrator term interacting with the closed loop, not from the plant. A 
conservative IMC-derived PI is sufficient to eliminate it.)

### Updated Performance Comparison

| Controller | Rise Time | Settling Time | Overshoot | Steady-State Error |
|---|---|---|---|---|
| Open-loop | 108.8 s | 189.8 s | 0% | 99.5% |
| P (Kp=1) | 36.6 s | 65.2 s | 0% | 33.3% |
| PI (Kp=1, Ki=0.5) | 8.1 s | 118.8 s | 52.7% | 0% |
| PID (Kp=1, Ki=0.5, Kd=1) | 8.8 s | 121.3 s | 51.2% | 0% |
| **IMC-tuned PI (Kp=2.5, Ki=0.05)** | 22.0 s | 39.2 s | **0%** | **0%** |

The systematically-tuned PI controller eliminates overshoot entirely and 
settles roughly 3x faster than the manually-tuned PID, while still 
maintaining zero steady-state error.

