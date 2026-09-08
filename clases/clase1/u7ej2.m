close all, clear all, clc

pkg load symbolic
pkg load control

syms s

Gpi = (s+0.1)/(s)
P = 12
G1 = 27/(s+200)
G2 = 5/(s+0.1)
-
