import os
import sys
import time
import steamworkspy as steamworks

def load_achievements_from_file(file_path):
    """
    Load achievement IDs from a text file.
    Each line should contain a single achievement ID.
    Empty lines and lines starting with # are ignored.
    """
    achievements = []
    try:
        with open(file_path, 'r') as f:
            for line in f:
                line = line.strip()
                if line and not line.startswith('#'):
                    achievements.append(line)
        return achievements
    except FileNotFoundError:
        print(f"Error: File {file_path} not found.")
        return None
    except Exception as e:
        print(f"Error reading file: {e}")
        return None

def trigger_achievements(app_id, achievements):
    """
    Trigger the specified achievements for the given app_id.
    """
    try:
        # Initialize the Steam API
        steamworks.initialize(app_id)
        
        # Get available achievements
        available_achievements = steamworks.get_achievement_names()
        print(f"Found {len(available_achievements)} achievements in app {app_id}")
        
        # Check which achievements from our list are valid
        valid_achievements = []
        invalid_achievements = []
        for achievement in achievements:
            if achievement in available_achievements:
                valid_achievements.append(achievement)
            else:
                invalid_achievements.append(achievement)
        
        if invalid_achievements:
            print("Warning: The following achievements were not found in the app:")
            for ach in invalid_achievements:
                print(f"  - {ach}")
        
        # Trigger each valid achievement
        for achievement in valid_achievements:
            print(f"Triggering achievement: {achievement}")
            result = steamworks.set_achievement(achievement)
            if result:
                print(f"  Success!")
            else:
                print(f"  Failed to trigger achievement.")
            
            # Small delay between achievements to avoid rate limiting
            time.sleep(0.5)
        
        # Store the stats to ensure they're saved
        steamworks.store_stats()
        print("All achievements processed.")
    
    except Exception as e:
        print(f"Error: {e}")
    finally:
        # Always clean up
        steamworks.shutdown()

def main():
    # Check command line arguments
    if len(sys.argv) != 3:
        print("Usage: python trigger_achievements.py <app_id> <achievements_file>")
        print("  <app_id>: The Steam app ID of the game")
        print("  <achievements_file>: Path to text file containing achievement IDs")
        return
    
    app_id = int(sys.argv[1])
    achievements_file = sys.argv[2]
    
    # Load achievements from file
    achievements = load_achievements_from_file(achievements_file)
    if not achievements:
        return
    
    print(f"Loaded {len(achievements)} achievements from {achievements_file}")
    
    # Confirm before proceeding
    confirm = input(f"Do you want to trigger {len(achievements)} achievements for app {app_id}? (y/n): ")
    if confirm.lower() != 'y':
        print("Operation cancelled.")
        return
    
    # Trigger the achievements
    trigger_achievements(app_id, achievements)

if __name__ == "__main__":
    main()
