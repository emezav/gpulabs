/**
 * @file
 * @author Erwin Meza Vega <emezav@unicauca.edu.co>, <emezav@gmail.com>
 * @brief GPU timer utility using CUDA events
 * @version 0.1
 * @date 2026-01-15
 * @copyright MIT License
 */

#ifndef GPU_TIMER_CUH
#define GPU_TIMER_CUH

#include <cuda_runtime.h>
#include <string>
#include <map>
#include <stdexcept>
#include <tuple>

namespace gpu_timer
{
  using std::map;
  using std::string;
  using std::tuple;
  class GpuEventTimer
  {
  public:

    /**
     * @brief Destroy the Gpu Event Timer instance
     */
    ~GpuEventTimer()
    {
      // Clean up all created events
      for (auto &pair : events)
      {
        cudaEventDestroy(std::get<0>(pair.second));
        cudaEventDestroy(std::get<1>(pair.second));
      }
    }

    /**
     * @brief Start timing an event
     * @param event_name Name of the event
     */
    void start(const string &event_name)
    {
      cudaEvent_t start_event, stop_event;
      // Create CUDA events
      cudaEventCreate(&start_event);
      cudaEventCreate(&stop_event);
      // Start recording the start event
      cudaEventRecord(start_event, 0);
      events[event_name] = std::make_tuple(start_event, stop_event);
    }

    /**
     * @brief Stop timing an event and return elapsed time in milliseconds
     * @param event_name Name of the event
     * @return float Elapsed time in milliseconds
     */
    float stop(const string &event_name)
    {
      auto it = events.find(event_name);
      if (it == events.end())
      {
        throw std::runtime_error("Elapsed time not foundfor event: " + event_name);
      }
      cudaEvent_t start_event = std::get<0>(it->second);
      cudaEvent_t stop_event = std::get<1>(it->second);
      cudaEventRecord(stop_event, 0);
      cudaEventSynchronize(stop_event);

      float milliseconds = 0;
      cudaEventElapsedTime(&milliseconds, start_event, stop_event);

      // Clean up events
      cudaEventDestroy(start_event);
      cudaEventDestroy(stop_event);
      events.erase(it);

      elapsed_times[event_name] = milliseconds;

      return milliseconds;
    }

    /**
     * @brief Get the elapsed time for a given event
     * @param event_name Name of the event
     * @return float Elapsed time in milliseconds
     */
    float elapsed(const string &event_name) const
    {
      auto it = elapsed_times.find(event_name);
      if (it == elapsed_times.end())
      {
        throw std::runtime_error("Elapsed time not found for event: " + event_name);
      }
      return it->second;
    }

  private:
    map<string, tuple<cudaEvent_t, cudaEvent_t>> events; /*!< CUDA events for timing */
    map<string, float> elapsed_times;                    /*!< Elapsed time in milliseconds for events */
  };
}

#endif // GPU_TIMER_CUH