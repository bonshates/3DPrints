/*************************************************************************************
 *
 * Parametric Multimeter Probe Tweezer
 *
 *************************************************************************************
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A
 * PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHOR OR COPYRIGHT
 * HOLDER BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
 * OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
 * SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 *
 * IT IS NOT PERMITTED TO MODIFY THIS COMMENT BLOCK.
 *
 * (c)2025, Claude "Tryphon" Theroux, Montreal, Quebec, Canada
 * http://www.ctheroux.com/
 *
 *************************************************************************************/

// Tweezer thickness in mm
lct_TweezerThickness = 3;

// Tweezer height in mm
lct_TweezerHeight = 10;

// Tweezer angle in degree
lct_TweezerAngle = 20;

// Ring external diameter in mm
lct_TweezerRingExternalDiameter = 30;

// Tweezer arm length excluding the ring in mm
lct_TweezerArmLength = 60;

// Probe holder width in mm
ProbeHolderWidth = 10;

// Probe holder diameter in mm
lct_ProbeDiameter = 10;

// Probe holder thickness in mm
lct_ProbeHolderThickness = 2;

// Probe holder angle in degree
ProbeHolderAngle = 15;

// Probe holder grabber in mm
ProbeHolderGrabberDiameter = 3;

$fn = 60;

lct_Debug = true;

module __Customizer_Limit__ () {}

/*************************************************************************************
 *
 * Nothing shall be modified below this line
 *
 *************************************************************************************/

lct_TweezerRingInternalDiameter = (lct_TweezerRingExternalDiameter - lct_TweezerThickness * 2);
lct_HiddenArmVerticalHeight = (lct_TweezerRingExternalDiameter - lct_TweezerThickness * 2) / ( 1 + tan(lct_TweezerAngle / 2)^2);
lct_HiddenArmHorizontalLength = lct_HiddenArmVerticalHeight * tan(lct_TweezerAngle / 2);
lct_ArmVerticalLength = lct_TweezerArmLength * cos(lct_TweezerAngle / 2);
lct_ArmHorizontalLength = lct_TweezerArmLength * sin(lct_TweezerAngle / 2);
lct_ArmOutsideHorizontalOffset = lct_TweezerThickness / cos(lct_TweezerAngle / 2);
lct_ArmOutsideVerticalOffset = sqrt(((lct_TweezerRingInternalDiameter / 2)^2 - lct_ArmOutsideHorizontalOffset^2));
lct_holderHorizontalOffset = lct_HiddenArmHorizontalLength + lct_ArmHorizontalLength + lct_ArmOutsideHorizontalOffset;
lct_holderExternalDiameter = lct_ProbeDiameter + lct_ProbeHolderThickness * 2;

module lct_Debug(p_EnableDebug = false) {
    if( p_EnableDebug ) {
        echo("lct_TweezerRingInternalDiameter:", lct_TweezerRingInternalDiameter);
        echo("lct_HiddenArmVerticalHeight:", lct_HiddenArmVerticalHeight);
        echo("lct_HiddenArmHorizontalLength:", lct_HiddenArmHorizontalLength);
        echo("lct_ArmVerticalLength:", lct_ArmVerticalLength);
        echo("lct_ArmHorizontalLength:", lct_ArmHorizontalLength);
        echo("lct_ArmOutsideHorizontalOffset:", lct_ArmOutsideHorizontalOffset);
        echo("lct_ArmOutsideVerticalOffset:", lct_ArmOutsideVerticalOffset);
        echo("lct_holderHorizontalOffset:", lct_holderHorizontalOffset);
    }
}

lct_Debug(lct_Debug);

lct_ExternalArms = [ [ -lct_ArmOutsideHorizontalOffset, 0 ], [ -lct_HiddenArmHorizontalLength - lct_ArmHorizontalLength - lct_ArmOutsideHorizontalOffset, lct_HiddenArmVerticalHeight + lct_ArmVerticalLength ], [ lct_HiddenArmHorizontalLength + lct_ArmHorizontalLength + lct_ArmOutsideHorizontalOffset, lct_HiddenArmVerticalHeight + lct_ArmVerticalLength ], [ lct_ArmOutsideHorizontalOffset, 0 ] ];

lct_InternalArms = [ [ 0, 0 ], [ -lct_HiddenArmHorizontalLength - lct_ArmHorizontalLength, lct_HiddenArmVerticalHeight + lct_ArmVerticalLength ], [ lct_HiddenArmHorizontalLength + lct_ArmHorizontalLength, lct_HiddenArmVerticalHeight + lct_ArmVerticalLength ] ];



lct_HiddenArms = [ [ 0, 0 ], [ -lct_HiddenArmHorizontalLength, lct_HiddenArmVerticalHeight ], [ lct_HiddenArmHorizontalLength, lct_HiddenArmVerticalHeight ] ];

module lct_Ring(p_ExternalArms) {
    linear_extrude(lct_TweezerHeight) difference() {
        circle(d = lct_TweezerRingExternalDiameter);
        color("red") translate( [ 0, -lct_ArmOutsideVerticalOffset, 0 ] ) polygon(p_ExternalArms);
        circle(d = lct_TweezerRingInternalDiameter);
    }
}

module lct_Arms(p_ExternalArms, p_InternalArms) {
    difference() {
        linear_extrude(lct_TweezerHeight) difference() {
            translate( [ 0, -lct_ArmOutsideVerticalOffset, 0 ] ) polygon(p_ExternalArms);
            translate( [ 0, -lct_ArmOutsideVerticalOffset, 0 ] ) polygon(p_InternalArms);
            circle(d = lct_TweezerRingInternalDiameter);
        }
    }
}

module lct_ProbeHolders() {

    halfProbeHolderSize = lct_holderExternalDiameter / 2;
    halfProbeSize = lct_ProbeDiameter / 2;
    
    cube( [ lct_ArmOutsideHorizontalOffset, lct_TweezerThickness, lct_TweezerHeight ] );
    
    holderOffset = lct_ArmOutsideHorizontalOffset - lct_TweezerThickness * sin(ProbeHolderAngle);

    translate( [ lct_TweezerThickness * sin(ProbeHolderAngle), 0, 0 ] ) rotate( [ 0, 0, -ProbeHolderAngle ] ) translate( [ -halfProbeHolderSize, lct_TweezerHeight, 0  ] ) rotate( [ 90, 0, 0] ) translate( [ 0, halfProbeHolderSize, 0  ] ) 
    
    
    union() {
        difference() {
            cylinder(d = lct_holderExternalDiameter, h = ProbeHolderWidth);
            cylinder(d = lct_ProbeDiameter, h = ProbeHolderWidth);
            translate( [ -lct_holderExternalDiameter / 2, 0, 0 ] ) cube( [ lct_holderExternalDiameter, lct_holderExternalDiameter, ProbeHolderWidth ] );
        }
        translate( [ -halfProbeSize - lct_ProbeHolderThickness, 0, 0 ] ) cube( [ lct_ProbeHolderThickness, halfProbeSize, ProbeHolderWidth ] );
        translate( [ halfProbeSize, 0, 0 ] ) cube( [ lct_ProbeHolderThickness, halfProbeSize, ProbeHolderWidth ] );

        translate( [ -(lct_ProbeDiameter - ProbeHolderGrabberDiameter) / 2 - lct_ProbeHolderThickness, halfProbeSize - ProbeHolderGrabberDiameter / 2, 0 ] ) cylinder(d = ProbeHolderGrabberDiameter, h = ProbeHolderWidth);
        translate( [ (lct_ProbeDiameter - ProbeHolderGrabberDiameter) / 2 + lct_ProbeHolderThickness, halfProbeSize - ProbeHolderGrabberDiameter / 2, 0 ] ) cylinder(d = ProbeHolderGrabberDiameter, h = ProbeHolderWidth);
    }
}

////////////////////////////////////////////////////////////////////////////////
//
// Tweezer generation
//

lct_Ring(lct_ExternalArms);
lct_Arms(lct_ExternalArms, lct_InternalArms);
translate( [ -lct_holderHorizontalOffset, lct_ArmVerticalLength + lct_ArmOutsideVerticalOffset, 0 ] ) lct_ProbeHolders();
mirror([ 1, 0, 0  ]) translate( [ -lct_holderHorizontalOffset, lct_ArmVerticalLength + lct_ArmOutsideVerticalOffset, 0 ] ) lct_ProbeHolders();
