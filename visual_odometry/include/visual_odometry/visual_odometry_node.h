/***************************************************************************
 *  include/visual_odometry/visual_odometry_node.h
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

#ifndef VISUALODOMETRY_VISUALODOMETRYNODE_H_
#define VISUALODOMETRY_VISUALODOMETRYNODE_H_

#include <quickdev/node.h>

// policies
#include <quickdev/image_proc_policy.h>

// classes
#include <quickdev/multi_publisher.h>
#include <quickdev/multi_subscriber.h>

// msgs
#include <geometry_msgs/TwistStamped.h> // for outgoing linear+angular velocity

typedef geometry_msgs::TwistStamped _TwistStampedMsg;

// Declare a node called VisualOdometryNode.
// A quickdev::RunablePolicy is automatically prepended to the list of policies our node will use.
// To use more policies, simply list them here:
//
// QUICKDEV_DECLARE_NODE( VisualOdometry, SomePolicy1, SomePolicy2 )
//
QUICKDEV_DECLARE_NODE( VisualOdometry )

// Declare a class called VisualOdometryNode
//
//! Subscribe to altitude and rectified image; publish 6-DOF velocity (ideally; maybe only publish XYZ + Yaw)
/*!
 *  Specifically, run optical flow, then use each laser dot as an altitude reference to calculate velocities.
 *  As the radius from the nearest laser dot increases (in pixel space), so should the certainty in the velocity
 *  estimation; however, information too close to the dots will be saturated. Use some kind of weighted sum to
 *  calculate the net linear/angular velocity; assume the ground is mostly rigid, but use ransac just in case.
 */
QUICKDEV_DECLARE_NODE_CLASS( VisualOdometry )
{
    ros::MultiPublisher multi_pub_;
    ros::MultiSubscriber multi_sub_;

    // Variable initializations can be appended to this constructor as a comma-separated list:
    //
    // QUICKDEV_DECLARE_NODE_CONSTRUCTOR( VisualOdometry ), member1_( some_value ), member2_( some_other_value ){}
    //
    QUICKDEV_DECLARE_NODE_CONSTRUCTOR( VisualOdometry )
    {
        //
    }

    // This function is called by quickdev::RunablePolicy after all policies are constructed but just before the main loop is started.
    // All policy initialization should be done here.
    //
    QUICKDEV_SPIN_FIRST()
    {
        QUICKDEV_GET_RUNABLE_NODEHANDLE( nh_rel );

        multi_sub_.addSubscriber( nh_rel, "laser_dots", quickdev::auto_bind( &VisualOdometryNode::laserDotsCB, this ) );
        multi_pub_.addPublishers<_TwistStampedMsg>( nh_rel, { "velocity" } );

        initPolicies<_ImageProcPolicy>
        (
            "image_callback_param", quickdev::auto_bind( &AdaptationMaskNode::imageCB, this )
        );

        initPolicies<quickdev::policy::ALL>();
    }
    
    QUICKDEV_DECLARE_MESSAGE_CALLBACK( laserDotsCB, _LaserDotArrayMsg )
    {
        //
    }

    QUICKDEV_DECLARE_IMAGE_CALLBACK( imageCB )
    {
        cv::Mat const & input_image = image_msg->image;

        // run visual odometry

        // for each laser dot we find:
        {
            _LaserDotMsg laser_dot_msg;
            laser_dot_msg.header.stamp = image_msg->header.stamp;
            laser_dots_msg.laser_dots.push_back( laser_dot_msg );
        }

        multi_pub_.publish( "laser_dots", laser_dots_msg ); 

        // do debug image stuff

        // if the output image is enabled and has subscribers, start doing work for it
        if( _ImageProcPolicy::image_pubs_.exists( "output_image" ) && _ImageProcPolicy::image_pubs_["output_image"].getNumSubscribers() )
        {
            cv::Mat output_image;
            _ImageProcPolicy::publishImages( "output_image", output_image );
        }
    }

    // This optional function is called by quickdev::RunablePolicy at a fixed rate (defined by the ROS param _loop_rate).
    // Most updateable policies should have their update( ... ) functions called within this context.
    //
    QUICKDEV_SPIN_ONCE()
    {
        //
    }
};

#endif // VISUALODOMETRY_VISUALODOMETRYNODE_H_
