/**
 * @file
 * @author Erwin Meza Vega <emezav@unicauca.edu.co>, <emezav@gmail.com>
 * @brief  CPU timer utility for GPU computing using CUDA
 * @copyright MIT License
 */
#ifndef CPU_TIMER_H
#define CPU_TIMER_H

#include <chrono>
#include <string>
#include <map>
#include <stdexcept>
#include <tuple>

namespace cpu_timer
{
  using std::map;
  using std::string;
  using std::tuple;
  using std::chrono::duration;
  using std::chrono::high_resolution_clock;
  class CpuEventTimer
  {
  public:

    /**
     * @brief Start timing an event
     * @param event_name Name of the event
     */
    void start(const string &event_name)
    {
      auto start_time = high_resolution_clock::now();
      events[event_name] = start_time;
    }

    /**
     * @brief Stop timing an event and return elapsed time in milliseconds
     * @param event_name Name of the event
     * @return float Elapsed time in milliseconds
     */
    float stop(const string &event_name)
    {
      auto end_time = high_resolution_clock::now();
      auto it = events.find(event_name);
      if (it == events.end())
      {
        throw std::runtime_error("Event not found: " + event_name);
      }

      auto start_time = it->second;

      // Get elapsed time in milliseconds (float)
      auto elapsed = std::chrono::duration_cast<std::chrono::microseconds>(end_time - start_time).count() / 1000.0f;

      // Delete the event after stopping
      events.erase(it);

      // Store elapsed time
      elapsed_times[event_name] = elapsed;
      return elapsed;
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
    std::map<string, high_resolution_clock::time_point> events; /*!< Start time of events */
    std::map<string, float> elapsed_times;                      /*!< Elapsed time in milliseconds for events */
  };
}

#endif // CPU_TIMER_H