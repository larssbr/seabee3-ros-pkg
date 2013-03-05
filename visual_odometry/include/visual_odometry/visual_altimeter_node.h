/***************************************************************************
 *  include/visual_odometry/visual_altimeter_node.h
 *  --------------------
 *
 *  Copyright (c) 2011, ekaszubski
 *  All rights reserved.
 *
 *  Redistribution and use in source and binary forms, with or without
 *  modification, are permitted provided that the following conditions are
 *  met:
 *
 *  * Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 *  * Redistributions in binary form must reproduce the above
 *    copyright notice, this list of conditions and the following disclaimer
 *    in the documentation and/or other materials provided with the
 *    distribution.
 *  * Neither the name of seabee3-ros-pkg nor the names of its
 *    contributors may be used to endorse or promote products derived from
 *    this software without specific prior written permission.
 *
 *  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 *  "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 *  LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
 *  A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
 *  OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 *  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
 *  LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
 *  DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
 *  THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
 *  OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *
 **************************************************************************/

#ifndef VISUALODOMETRY_VISUALALTIMETERNODE_H_
#define VISUALODOMETRY_VISUALALTIMETERNODE_H_

#include <quickdev/node.h>

// policies
#include <quickdev/tf_tranceiver_policy.h>

// classes
#include <quickdev/multi_subscriber.h>
#include <quickdev/multi_publisher.h>

// utils
#include <quickdev/geometry_message_conversions.h>

// msgs
#include <visual_odometry/LaserDotArray.h>

typedef quickdev::TfTranceiverPolicy _TfTranceiverPolicy;

typedef visual_odometry::LaserDotArray _LaserDotArrayMsg;

// Declare a node called VisualAltimeterNode.
// A quickdev::RunablePolicy is automatically prepended to the list of policies our node will use.
// To use more policies, simply list them here:
//
// QUICKDEV_DECLARE_NODE( VisualAltimeter, SomePolicy1, SomePolicy2 )
//
QUICKDEV_DECLARE_NODE( VisualAltimeter, _TfTranceiverPolicy )

// Declare a class called VisualAltimeterNode
//
//! Subscribe to LaserDotArray messages, publish LaserDotArray messags
/*!
 *  Specifically, given the unit vector for each laser dot (from the camera's perspective), the pose of the camera, and the pose of each dot's laser emitter,
 *  calculate actual position of each laser dot relative to the camera
 */
QUICKDEV_DECLARE_NODE_CLASS( VisualAltimeter )
{
    // Variable initializations can be appended to this constructor as a comma-separated list:
    //
    // QUICKDEV_DECLARE_NODE_CONSTRUCTOR( VisualAltimeter ), member1_( some_value ), member2_( some_other_value ){}
    //
    QUICKDEV_DECLARE_NODE_CONSTRUCTOR( VisualAltimeter )
    {
        //
    }

    // This function is called by quickdev::RunablePolicy after all policies are constructed but just before the main loop is started.
    // All policy initialization should be done here.
    //
    QUICKDEV_SPIN_FIRST()
    {
        QUICKDEV_GET_RUNABLE_NODEHANDLE( nh_rel );

        multi_pub_.addPublishers<_LaserDotArrayMsg>( nh_rel, { "input_laser_dots" } );
        multi_sub_.addSubscriber( nh_rel, "output_laser_dots", quickdev::auto_bind( &VisualAltimeterNode::laserDotsCB, this ) );

        initPolicies<quickdev::policy::ALL>();
    }

    QUICKDEV_DECLARE_MESSAGE_CALLBACK( laserDotsCB, _LaserDotArrayMsg )
    {
        //
    }

    // This optional function is called by quickdev::RunablePolicy at a fixed rate (defined by the ROS param _loop_rate).
    // Most updateable policies should have their update( ... ) functions called within this context.
    //
    QUICKDEV_SPIN_ONCE()
    {
        //
    }
};

#endif // VISUALODOMETRY_VISUALALTIMETERNODE_H_
