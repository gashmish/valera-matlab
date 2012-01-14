function s = load_dump( file )
    str = fileread( file );
    dump = xml_parseany( str );
    
    acceler = dump.accelerList{1, 1};
    numberOfSamples = str2num(acceler.ATTRIBUTE.length);
    
    samples = struct('time', {}, 'x', {}, 'y', {}, 'z', {});
        
    for i = 1 : numberOfSamples
       data = acceler.accelerMessage{1, i}.ATTRIBUTE;
       samples(i) = struct( ...
           'time', data.time, ...
           'x', data.x, ...
           'y', data.y, ...
           'z', data.z);
    end
    
    tapsTimes = dump.tapsTimes{1, 1};
    numberOfTaps = str2num(tapsTimes.ATTRIBUTE.length);
    
    taps = struct('time', {});
    
    for i = 1 : numberOfTaps
        tap = tapsTimes.long{1, i}.CONTENT;
        taps(i) = struct('time', tap);
    end

    s = struct('samples', samples, 'taps', taps);
end
