include "premake_of.lua"

newoption {
    trigger = "OF_ROOT",
    value = "",
    description = "Choose openframeworks dir",
}

if(_OPTIONS["OF_ROOT"]) then
    OF_ROOT = _OPTIONS["OF_ROOT"]
else
    OF_ROOT = search_of_root()
end

print ("OF_ROOT = " .. OF_ROOT)

APP_NAME = "ofApp"

workspace "MyPremakeApp"
    location "visual_studio"
    configurations { "Debug", "Release" }

architecture "x86_64"

externalproject "openframeworksLib"
    location "%{OF_ROOT}/libs/openFrameworksCompiled/project/vs/" 
    kind     "StaticLib"
    language "C++"

project "MyPremakeApp"
    kind "ConsoleApp"
    language "C++"
    targetdir "bin/"
    systemversion "latest"
    
    files { "src/**.h", "src/**.cpp" }

    dependson { "openframeworksLib" }
    links { "openframeworksLib" }

    symbols "On"

    filter {"Debug"}
        targetname ("%{APP_NAME}_Debug")
        optimize "Off"
        add_of_dependency_debug()
    filter {"Release"}
        targetname ("%{APP_NAME}")
        optimize "Full"
        add_of_dependency_release()
        
