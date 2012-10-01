/***************************************************************************
 *  include/ground_truth/ground_truth_node.h
 *  --------------------
 *
 *  Copyright (c) 2011, dhruv
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
 *  * Neither the name of quickdev-doc nor the names of its
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

#ifndef GROUNDTRUTH_GROUNDTRUTHNODE_H_
#define GROUNDTRUTH_GROUNDTRUTHNODE_H_

#include <quickdev/node.h>
#include <quickdev/image_proc_policy.h>

typedef quickdev::ImageProcPolicy _ImageProcPolicy;

// Declare a node called groundTruthNode.
// A quickdev::RunablePolicy is automatically prepended to the list of policies our node will use.
// To use more policies, simply list them here:
//
// QUICKDEV_DECLARE_NODE( groundTruth, SomePolicy1, SomePolicy2 )
//
QUICKDEV_DECLARE_NODE( groundTruth, _ImageProcPolicy )

    // Declare a class called groundTruthNode
    //
QUICKDEV_DECLARE_NODE_CLASS( groundTruth )
{

    static void on_change(int state, void *userdata)
    {
        ROS_INFO( "Button Pushed. State: %d", state );
    }

    // Variable initializations can be appended to this constructor as a comma-separated list:
    //
    // QUICKDEV_DECLARE_NODE_CONSTRUCTOR( groundTruth ), member1_( some_value ), member2_( some_other_value ){}
    //
    std::vector<cv::Mat> image_channels_;
    QUICKDEV_DECLARE_NODE_CONSTRUCTOR( groundTruth ),
        image_channels_( 3 )
        {
            cv::namedWindow( "Ground_Truth", CV_WINDOW_AUTOSIZE | CV_GUI_EXPANDED );
            cvCreateButton( "Next_Image", &on_change, NULL, CV_PUSH_BUTTON, 0 );
            int value = 50;
            cvCreateTrackbar( "track", "Ground_Truth", &value, 255, NULL );
        }

    // This function is called by quickdev::RunablePolicy after all policies are constructed but just before the main loop is started.
    // All policy initialization should be done here.
    //
    QUICKDEV_SPIN_FIRST()
    {
        initPolicies<_ImageProcPolicy>
            (
             "image_callback_param", quickdev::auto_bind( &groundTruthNode::imageCB, this)
            );
        // Say we had a policy called _SomePolicy that looked for the meta-parameter "some_value1_param" of type SomeType and
        // "some_value2_param" of type SomeOtherType in its init function
        // We can create those meta-params here and then pass them to all policies using initPolicies<...>():
        //
        // initPolicies<quickdev::policy::ALL>( "some_value1_param", SomeType(), "some_value2_param", SomeOtherType() );
        //
        // Or we can pass those meta-params only to _SomePolicy by specifying its type:
        //
        // initPolicies<_SomePolicy>( "some_value1_param", SomeType(), "some_value2_param", SomeOtherType() );
        //
        // If we want to initialize all policies and use their default values, we can simply call initPolicies<quickdev::policy::ALL>()
        // with no arguments.
        // Note that most initable policies won't function properly unless their init() functions are called directly or via initPolicies<...>().
        // Furthermore, since each policy is required to track its initialization state, initPolicies<...>() is guaranteed to only call init()
        // on policies that have yet to be initialized; therefore, calling initPolicies<quickdev::policy::ALL>() at the end of QUICKDEV_SPIN_FIRST()
        // is always a safe operation.
        // To instead force re-initialization, call forceInitPolicies<...>().
        //
        initPolicies<quickdev::policy::ALL>();
    }

    QUICKDEV_DECLARE_IMAGE_CALLBACK( imageCB )
    {
        cv::Mat const & image = image_msg->image;

        cv::Mat rw_image( image );

        publishImages( "output_image", quickdev::opencv_conversion::fromMat( rw_image, "", "mono8") );

        cv::imshow( "Ground_Truth", rw_image );

        cvWaitKey( 20 );


    }

    // This optional function is called by quickdev::RunablePolicy at a fixed rate (defined by the ROS param _loop_rate).
    // Most updateable policies should have their update( ... ) functions called within this context.
    //
    QUICKDEV_SPIN_ONCE()
    {
        //
    }
};
#endif
