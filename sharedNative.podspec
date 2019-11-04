Pod::Spec.new do |spec|
    spec.name                     = 'sharedNative'
    spec.version                  = '1.0.0'
    spec.homepage                 = 'https://github.com/'
    spec.source                   = { :git => "https://github.com/FuruyamaTakeshi/Samples.git" }
    spec.source_files             = 'KotlinNativeiOS/*'
    spec.authors                  = ''
    spec.license                  = ''
    spec.summary                  = 'This is a sample summary'
    spec.license                  = { :type => 'MIT', :file => 'LICENSE' }

    spec.static_framework         = true
    spec.vendored_frameworks      = "KotlinNativeiOS/sharedNative/cocoapods/framework/#{spec.name}.framework"
    spec.libraries                = "c++"
    spec.module_name              = "#{spec.name}_umbrella"



    spec.pod_target_xcconfig = {
        'KOTLIN_TARGET[sdk=iphonesimulator*]' => 'ios_x64',
        'KOTLIN_TARGET[sdk=iphoneos*]' => 'ios_arm',
        'KOTLIN_TARGET[sdk=macosx*]' => 'macos_x64'
    }

    spec.script_phases = [
        {
            :name => 'Build sharedNative',
            :execution_position => :before_compile,
            :shell_path => '/bin/sh',
            :script => <<-SCRIPT
                set -ev
                REPO_ROOT="$PODS_TARGET_SRCROOT"
      		./gradlew --no-daemon -Pframework=#{spec.name}.framework --stacktrace --info
            SCRIPT
        }
    ]
end
