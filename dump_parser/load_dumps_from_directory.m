function d = load_dumps_from_directory(path)
    originalFolder = cd(path);
    directories = dir();

    dumps = struct('name', {}, 'dump', {});
    
    for k = 3 : length(directories)
        if directories(k).isdir == 0
            continue;
        end
        
        directory = directories(k).name;
        
        previousFolder = cd(directory);
        files = dir(fullfile('*.xml'));
        
        for i = 1 : length(files)
            
            name = files(i).name;
            dump = load_dump(name);
            
            id = strcat(directory, '/', name)
            
            dumps(end + 1) = struct('name', id, 'dump', dump);
        end
        
        cd(previousFolder)
    end
    
    cd(originalFolder)
    d = dumps;
end
