function find_packet_marker(signal)
    for i in 4:length(signal)
        if length(Set(signal[i-3:i])) == 4
            return i
        end
    end
end

function find_message_marker(signal)
    for i in 14:length(signal)
        if length(Set(signal[i-13:i])) == 14
            return i
        end
    end
end

function day06a(signal)
    return find_packet_marker(signal)
end

function day06b(signal)
    return find_message_marker(signal)
end

function day06(fpath)
    signal = readline(fpath)
    return (day06a(signal), day06b(signal))
end