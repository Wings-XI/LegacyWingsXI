#include <random>
#include "pcg/pcg_random.hpp"

#ifndef RNG
#define RNG pcg32
#endif

// PCG-based RNG for DSP/Topaz by Setzor from Eden
class tpzrand
{
    // ATTR: Squirrel Eiserloh https://www.gdcvault.com/play/1024365/Math-for-Game-Programmers-Noise
    static uint32_t Squirrel3(int32_t position, uint32_t seed) {
        constexpr uint32_t BIT_NOISE1 = 0xB5297A4D;
        constexpr uint32_t BIT_NOISE2 = 0x68E31DA4;
        constexpr uint32_t BIT_NOISE3 = 0x1B56C4E9;

        uint32_t mangled = position;
        mangled *= BIT_NOISE1;
        mangled += seed;
        mangled ^= (mangled >> 8);
        mangled += BIT_NOISE2;
        mangled ^= (mangled << 8);
        mangled *= BIT_NOISE3;
        mangled ^= (mangled >> 8);
        return mangled;
    }

    static double get() {
        static const thread_local uint32_t s_seed = std::random_device()();
        static thread_local int32_t s_position = 0;
        uint32_t result = Squirrel3(s_position++, s_seed);
        return (double)result / UINT32_MAX;
    }

public:
    /*Generates a random number in the half-open interval [min, max)
    @param min
    @param max
    @returns result
    */
    template <typename T>
    static inline typename std::enable_if<std::is_integral<T>::value, T>::type GetRandomNumber(T min, T max)
    {
        if (min >= max - 1)
        {
            return min;
        }
        thread_local pcg_extras::seed_seq_from<std::random_device> seed_source;
        static thread_local bool firstCall = true;
        static thread_local RNG rng(seed_source);
        static thread_local uint64_t s_stream = (uint64_t)time(nullptr);
        static thread_local uint8 incr = (uint8)(10 * get()) + 1;
        if (firstCall)
        {
            uint64_t discard_amt = (uint64_t)(10000000 * get());
            rng.discard(discard_amt);
            firstCall = false;
        }
        rng.set_stream(s_stream+=incr);
        std::uniform_int_distribution<T> dist(min, max - 1);
        return dist(rng);
    }

    template <typename T>
    static inline typename std::enable_if<std::is_floating_point<T>::value, T>::type GetRandomNumber(T min, T max)
    {
        if (min >= max)
        {
            return min;
        }
        thread_local pcg_extras::seed_seq_from<std::random_device> seed_source;
        static thread_local RNG rng(seed_source);
        static thread_local bool firstCall = true;
        static thread_local uint64_t s_stream = (uint64_t)time(nullptr);
        static thread_local uint8 incr = (uint8)(10 * get()) + 1;
        if (firstCall)
        {
            uint64_t discard_amt = (uint64_t)(10000000 * get());
            rng.discard(discard_amt);
            firstCall = false;
        }
        rng.set_stream(s_stream+=incr);
        double value = 0x1.0p-32 * rng();
        return T(min * (1.0 - value) + max * value);
    }

    /*Generates a random number in the half-open interval [0, max)
    @param min
    @param max
    @returns result
    */
    template <typename T>
    static inline T GetRandomNumber(T max)
    {
        return GetRandomNumber<T>(T(0), max);
    }

    // Gets a random element from the given stl-like container (container must have members: at() and size()).
    // @param container
    // @returns result
    template <typename T> static inline typename T::value_type GetRandomElement(T* container)
    {
        // NOTE: the specialisation for integral types uses: dist(min, max - 1), so no need to offset container->size()
        return container->at(GetRandomNumber<std::size_t>(0U, container->size()));
    }

    // Gets a random element from the given stl-like container (container must have members: at() and size()).
    // @param container
    // @returns result
    template <typename T> static inline typename T::value_type GetRandomElement(T& container)
    {
        return GetRandomElement(&container);
    }

    // Gets a random element from the given initializer_list.
    // @param initializer_list
    // @returns result
    template <typename T> static inline T GetRandomElement(std::initializer_list<T> list)
    {
        std::vector<T> container(list);
        return GetRandomElement(container);
    }

    // Topaz compatibility
    template <typename T>
    class urng {
    public:
        using result_type = T;

        static constexpr T min() {
            return std::numeric_limits<T>::min();
        }
        static constexpr T max() {
            return std::numeric_limits<T>::max();
        }

        T operator()() { return GetRandomNumber<T>(max()); }
    };

    class mt : public urng<uint32_t> {};
    static void seed() {}
};
