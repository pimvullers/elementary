# Copyright 2021 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit gnome2 meson

DESCRIPTION="Pantheon DE shell"
HOMEPAGE="https://github.com/elementary/session-settings"
SRC_URI="https://github.com/elementary/session-settings/archive/${PV}.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}/session-settings-${PV}"

LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64"
IUSE="accessibility gnome-keyring wayland systemd"

RDEPEND="${DEPEND}
	accessibility? (
		app-accessibility/orca
	)
	gnome-base/gnome-session
	gnome-base/gnome-settings-daemon
	gnome-base/gsettings-desktop-schemas
	gnome-keyring? ( gnome-base/gnome-keyring )
	pantheon-base/applications-menu
	pantheon-base/wingpanel
	pantheon-extra/pantheon-agent-polkit
	pantheon-base/pantheon-dock
	x11-wm/gala
"

PDEPEND="
	pantheon-base/pantheon-settings
"

src_prepare() {
	eapply_user

	use accessibility || sed -i -e "/orca/d" session/meson.build
	use accessibility || sed -i -e "/onboard/d" session/meson.build
	use gnome-keyring || sed -i -e "/gnome-keyring/d" session/meson.build
}

src_configure() {
	local emesonargs=(
		-Dsystemd=$(usex systemd true false)
		-Dwayland=$(usex wayland true false)
	)

	meson_src_configure
}
