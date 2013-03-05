/***************************************************************************
 *  include/visual_odometry/laser_dot_finder_node.h
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

#ifndef VISUALODOMETRY_LASERDOTFINDERNODE_H_
#define VISUALODOMETRY_LASERDOTFINDERNODE_H_

#include <quickdev/node.h>

// policies
#include <quickdev/image_proc_policy.h>

// utils
#include <quickdev/multi_publisher.h>

// msgs
#include <visual_odometry/LaserDotArray.h>
#include <sensor_msgs/CameraInfo.h>

typedef quickdev::ImageProcPolicy _ImageProcPolicy;

typedef visual_odometry::LaserDotArray _LaserDotArrayMsg;
typedef visual_odometry::LaserDot _LaserDotMsg;
typedef sensor_msgs::CameraInfo _CameraInfoMsg;

// Declare a node called LaserDotFinderNode.
// A quickdev::RunablePolicy is automatically prepended to the list of policies our node will use.
// To use more policies, simply list them here:
//
// QUICKDEV_DECLARE_NODE( LaserDotFinder, SomePolicy1, SomePolicy2 )
//
QUICKDEV_DECLARE_NODE( LaserDotFinder, _ImageProcPolicy )

// Declare a class called LaserDotFinderNode
//
//! Find laser dots in an image and publish their locations in pixel space
QUICKDEV_DECLARE_NODE_CLASS( LaserDotFinder )
{
    ros::MultiPublisher<> multi_pub_;

    // Variable initializations can be appended to this constructor as a comma-separated list:
    //
    // QUICKDEV_DECLARE_NODE_CONSTRUCTOR( LaserDotFinder ), member1_( some_value ), member2_( some_other_value ){}
    //
    QUICKDEV_DECLARE_NODE_CONSTRUCTOR( LaserDotFinder )
    {
        //
    }

    // This function is called by quickdev::RunablePolicy after all policies are constructed but just before the main loop is started.
    // All policy initialization should be done here.
    //
    QUICKDEV_SPIN_FIRST()
    {
        QUICKDEV_GET_RUNABLE_NODEHANDLE( nh_rel );
        
        multi_pub_.addPublishers<_LaserDotArrayMsg>( nh_rel, { "laser_dots" } );
        multi_sub_.addSubscriber( nh_rel, "camera_info", quickdev::auto_bind( &LaserDotFinderNode::cameraInfoCB, this ) )

        initPolicies<_ImageProcPolicy>
        (
            "image_callback_param", quickdev::auto_bind( &AdaptationMaskNode::imageCB, this )
        );

        initPolicies<quickdev::policy::ALL>();
    }

    QUICKDEV_DECLARE_MESSAGE_CALLBACK( cameraInfoCB, _CameraInfoMsg )
    {
        //
    }

    QUICKDEV_DECLARE_IMAGE_CALLBACK( imageCB )
    {
        cv::Mat const & input_image = image_msg->image;

        _LaserDotArrayMsg laser_dots_msg;

        // do magical image proc stuff to find laser dots

        // for each laser dot we find:
        {
            _LaserDotMsg laser_dot_msg;
            laser_dot_msg.header.stamp = image_msg->header.stamp;
            laser_dot_msg.header.frame_id = image_msg->header.frame_id;
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

#endif // VISUALODOMETRY_LASERDOTFINDERNODE_H_
