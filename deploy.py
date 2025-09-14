#!/usr/bin/env python3
"""
Simple CLI deployment interface for Día de Muertos RunPod
Quick deployment without full web interface
"""

import argparse
import subprocess
import sys
import time
from pathlib import Path
from rich.console import Console
from rich.panel import Panel
from rich.prompt import Prompt, Confirm
from rich.table import Table

console = Console()

class DDMDeployment:
    def __init__(self):
        self.script_dir = Path(__file__).parent
        self.available_scripts = self.discover_scripts()
    
    def discover_scripts(self):
        """Discover available deployment scripts"""
        scripts = {}
        for script_file in self.script_dir.glob("*.sh"):
            if script_file.name != "ddm_modern_deploy.sh":
                scripts[script_file.stem] = {
                    "path": script_file,
                    "description": self.get_script_description(script_file.name)
                }
        
        # Add the new modern deployment
        scripts["modern"] = {
            "path": self.script_dir / "ddm_modern_deploy.sh",
            "description": "🎭 Modern DDM deployment with @DRKV8R/ENDS agent"
        }
        
        return scripts
    
    def get_script_description(self, filename):
        """Get description for deployment script"""
        descriptions = {
            "ddm_optimized.sh": "💀 Optimized Día de Muertos deployment",
            "ddm_modern_deploy.sh": "🎭 Modern DDM deployment with @DRKV8R/ENDS agent",
            "ddm_ultra_optimized.sh": "⚡ Ultra-optimized DDM with shared library (FASTEST)",
            "ddm_quick.sh": "🚀 Quick DDM deployment for rapid prototyping",
            "default.sh": "📦 Standard ComfyUI deployment",
            "skyreels_installer.sh": "🎬 Video-focused SkyReels deployment",
            "i2v_hunyuan.sh": "🎞️ Image-to-video with HunyuanVideo",
            "wan21_img2vid.sh": "🎯 WAN 2.1 video generation",
            "videoworkflow.sh": "🎥 Comprehensive video workflow",
            "civitai.sh": "🏛️ CivitAI model integration",
            "kohya.sh": "🔧 Kohya training environment"
        }
        return descriptions.get(filename, "🛠️ ComfyUI deployment script")
    
    def show_banner(self):
        """Display application banner"""
        console.print(Panel.fit(
            "[bold red]🎭 Día de Muertos RunPod Influencer[/bold red]\n"
            "[cyan]Modern AI deployment platform[/cyan]\n"
            "[yellow]Enhanced with @DRKV8R/ENDS automation[/yellow]",
            title="🚀 DDM Deployment",
            border_style="red"
        ))
    
    def show_scripts(self):
        """Display available deployment scripts"""
        table = Table(title="Available Deployment Scripts")
        table.add_column("ID", style="cyan", width=12)
        table.add_column("Script", style="green", width=20)
        table.add_column("Description", style="yellow")
        
        for script_id, script_info in self.available_scripts.items():
            table.add_row(
                script_id,
                script_info["path"].name,
                script_info["description"]
            )
        
        console.print(table)
    
    def interactive_deploy(self):
        """Interactive deployment selection"""
        self.show_banner()
        self.show_scripts()
        
        # Get user selection
        script_choices = list(self.available_scripts.keys())
        script_id = Prompt.ask(
            "Choose deployment script",
            choices=script_choices,
            default="modern"
        )
        
        script_info = self.available_scripts[script_id]
        
        console.print(f"\n[green]Selected:[/green] {script_info['description']}")
        
        if Confirm.ask(f"Deploy with {script_info['path'].name}?"):
            return self.deploy_script(script_info["path"])
        else:
            console.print("[yellow]Deployment cancelled[/yellow]")
            return False
    
    def deploy_script(self, script_path):
        """Execute deployment script"""
        console.print(f"\n[green]🚀 Starting deployment with {script_path.name}[/green]")
        
        try:
            # Run the deployment script
            process = subprocess.Popen(
                ["bash", str(script_path)],
                stdout=subprocess.PIPE,
                stderr=subprocess.STDOUT,
                universal_newlines=True,
                bufsize=1
            )
            
            # Stream output
            for line in process.stdout:
                console.print(line.rstrip())
            
            process.wait()
            
            if process.returncode == 0:
                console.print("\n[bold green]✅ Deployment completed successfully![/bold green]")
                return True
            else:
                console.print(f"\n[bold red]❌ Deployment failed with exit code {process.returncode}[/bold red]")
                return False
                
        except KeyboardInterrupt:
            console.print("\n[yellow]⚠️ Deployment interrupted by user[/yellow]")
            process.terminate()
            return False
        except Exception as e:
            console.print(f"\n[bold red]❌ Deployment error: {e}[/bold red]")
            return False
    
    def quick_deploy(self, script_name=None):
        """Quick deployment without interaction"""
        script_name = script_name or "modern"
        
        if script_name not in self.available_scripts:
            console.print(f"[red]Error: Script '{script_name}' not found[/red]")
            return False
        
        script_info = self.available_scripts[script_name]
        console.print(f"[green]Quick deploying with {script_info['path'].name}[/green]")
        
        return self.deploy_script(script_info["path"])


def main():
    parser = argparse.ArgumentParser(description="Día de Muertos RunPod Deployment")
    parser.add_argument("--script", "-s", help="Script to deploy (modern, ddm_optimized, etc.)")
    parser.add_argument("--list", "-l", action="store_true", help="List available scripts")
    parser.add_argument("--quick", "-q", action="store_true", help="Quick deploy without interaction")
    
    args = parser.parse_args()
    
    deployer = DDMDeployment()
    
    if args.list:
        deployer.show_scripts()
        return
    
    if args.quick:
        success = deployer.quick_deploy(args.script)
    else:
        success = deployer.interactive_deploy()
    
    sys.exit(0 if success else 1)


if __name__ == "__main__":
    main()