#!/usr/bin/env python3
import os
from launch import LaunchDescription
from launch.actions import IncludeLaunchDescription
from launch.launch_description_sources import PythonLaunchDescriptionSource
from launch_ros.actions import Node
from ament_index_python.packages import get_package_share_directory

def generate_launch_description():
    # 获取 Gazebo 的包路径和模型路径
    pkg_gazebo= get_package_share_directory('gazebo_ros')
    pkg_model = get_package_share_directory('uwrobot_description')
    world_path = os.path.join(pkg_model, 'world', 'empty.world')
    # URDF
    urdf_path = os.path.join(pkg_model, 'urdf', 'uwrobot.urdf')
    with open(urdf_path, 'r') as f:
        robot_desc = f.read()

    # 1) 发布 URDF
    robot_state_publisher = Node(
        package='robot_state_publisher',
        executable='robot_state_publisher',
        parameters=[{
            'robot_description': robot_desc,
            'use_sim_time': True
        }],
    )

    # 2) 启动 Gazebo
    gazebo = IncludeLaunchDescription(
        PythonLaunchDescriptionSource(
            os.path.join(pkg_gazebo, 'launch', 'gazebo.launch.py')
        ),
        launch_arguments=[
            ('verbose','true'),
            ('world',   world_path)
        ],
    )

    # 3) spawn 模型
    spawn = Node(
        package='gazebo_ros',
        executable='spawn_entity.py',
        arguments=[
            '-topic', '/robot_description',
            '-entity','zh_bot'
            ,'-x','0','-y','0','-z','0.4'
        ],
        output='screen'
    )   

    # 4) 用 spawner 加载 controllers
    joint_state_spawner = Node(
        package='controller_manager',
        executable='spawner',
        arguments=['joint_state_broadcaster'],
        output='screen'
    )
    velocity_spawner = Node(
        package='controller_manager',
        executable='spawner',
        arguments=['velocity_controller'],
        output='screen'
    )
    steering_spawner = Node(
        package='controller_manager',
        executable='spawner',
        arguments=['steering_controller'],
        output='screen'
    )

    return LaunchDescription([
        robot_state_publisher,
        gazebo,
        spawn,
        joint_state_spawner,
        velocity_spawner,
        steering_spawner,
    ])