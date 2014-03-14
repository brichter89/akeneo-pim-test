def Kernel.is_windows?
    # Detect if we are running on Windows
    processor, platform, *rest = RUBY_PLATFORM.split("-")
    return platform == 'mingw32'
end
