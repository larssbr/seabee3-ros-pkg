# Seabee's New Hull #

So it looks like we'll be making a new hull to get a lot more room internally.

Current plan is to have a foot-long, 1/8"-thick, 8.5"-ID cast acyrlic hull with aluminum endcaps.
  * Safety factor still around 7 at bottom of Transdec.
  * Looks cool.
  * Transparent.
  * Corrosion-resistant.

<img src='http://i.imgur.com/LgmTT0o.jpg'>
<b>Figure 1</b> - <i>Rendered Feb 11, 2013.  Endcap will be rigidly mounted to external frame (not shown).  Radiator/pressure valve also not shown.  Internal frame still needs an update (greater spacing/take into account powerboard, and 1 fewer rack.  Need to add pump, hard drive, and ADL)</i>

(Everything below this is kinda... out of date... but still valid.  I already did some stress (including thermal expansion) analysis on the acrylic/aluminum hull, but didn't take the time to write 'em down or take screenshots.. )<br>
<br>
<h2>Stress Analysis</h2>
To cut down on unnecessary weight, the hull's thickness will determined via FEA.  Perhaps even a change of material.. but the current aluminum 6061-T6 should be a good choice.<br>
<br>
<h3>Preliminary Stress Analysis (no endcap/axial pressure)</h3>
<i>Jan 28, 2013 via Solidworks Simulation Package</i>
<img src='http://i.imgur.com/4gVhIyx.jpg' />
<ul><li>Simulated pressure test at bottom of Transdec (11 meters deep)<br>
</li><li>External pressure set at 100 kPa with varying hull thicknesses.<br>
</li><li>Hull's average diameter set constant at 9", 12" length, aluminum 6061-T6.<br>
</li><li>Yield strength of aluminum 6061-T6 is 250 MPa<br>
<table><thead><th> <b>Thickness(in)</b> </th><th> <b>Max Stress (MPa)</b> </th><th> <b>Factor of Safety</b> </th><th> <b>Weight(lbs)</b> </th></thead><tbody>
<tr><td>3/8                   </td><td>1.3                      </td><td>211                      </td><td>12.4                </td></tr>
<tr><td>1/4                   </td><td>1.9                      </td><td>144                      </td><td>8.27                </td></tr>
<tr><td>3/16 --current        </td><td>2.5                      </td><td>109.8                    </td><td>6.2                 </td></tr>
<tr><td>1/8                   </td><td>3.7                      </td><td>74.16                    </td><td>4.??                </td></tr>
<tr><td>1/16                  </td><td>7.3                      </td><td>37.61                    </td><td>2.07                </td></tr>
</li><li><b>Conclusion</b> - theoretically, 1/16"-thick hull can tolerate 30x the pressure experienced at the bottom of Transdec. (For comparison's sake.. pressure vessels are usually designed to a FoS of 4 according to the all-knowing wikipedia.)</li></ul></tbody></table>

<h4>Prefer the analytic solution??</h4>
In case you don't trust solidworks or FEA... or you just enjoy math..  double-check the validity using these thin-wall approximations.<br>
<img src='http://i.imgur.com/VaHYFhX.jpg' />

(Note - the FEA analysis only looked at hoop stress.. for obvious reasons.)